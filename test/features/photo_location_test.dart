import 'dart:async';

import 'package:drift/native.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geocoding/geocoding.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:smart_memory_preservation/core/database/app_database.dart';
import 'package:smart_memory_preservation/core/database/memory_snapshot_repository.dart';
import 'package:smart_memory_preservation/core/models/capture_location.dart';
import 'package:smart_memory_preservation/core/models/memory_models.dart';
import 'package:smart_memory_preservation/features/event_management/data/device_place_name_gateway.dart';
import 'package:smart_memory_preservation/features/event_management/domain/services/place_name_gateway.dart';
import 'package:smart_memory_preservation/features/event_management/presentation/memory_controller.dart';
import 'package:smart_memory_preservation/features/media_import/data/photo_manager_media_import_gateway.dart';
import 'package:smart_memory_preservation/features/media_import/domain/media_import_gateway.dart';

void main() {
  test(
    'validates GPS, rejects missing sentinels, and retains equator/meridian',
    () {
      for (final pair in <(double?, double?)>[
        (null, null),
        (10, null),
        (null, 10),
        (0, 0),
        (91, 1),
        (1, -181),
        (double.nan, 1),
        (1, double.infinity),
      ]) {
        expect(CaptureLocation.fromCoordinates(pair.$1, pair.$2), isNull);
      }
      expect(CaptureLocation.fromCoordinates(0, 30), isNotNull);
      expect(CaptureLocation.fromCoordinates(-30, 0), isNotNull);
      expect(
        CaptureLocation.fromCoordinates(-12.5, -45.25)!.label,
        '12.50000° S, 45.25000° W',
      );
    },
  );

  test('place names skip empty values and duplicate administrative names', () {
    expect(
      DevicePlaceNameGateway.formatPlaceName(
        const Placemark(
          locality: ' ',
          subAdministrativeArea: 'Karur',
          administrativeArea: 'Tamil Nadu',
          country: 'India',
        ),
      ),
      'Karur, Tamil Nadu, India',
    );
    expect(
      DevicePlaceNameGateway.formatPlaceName(
        const Placemark(
          locality: 'Singapore',
          administrativeArea: 'Singapore',
          country: 'Singapore',
        ),
      ),
      'Singapore',
    );
    expect(DevicePlaceNameGateway.formatPlaceName(const Placemark()), isEmpty);
  });

  test(
    'reads asynchronous EXIF even when synchronous coordinates are absent',
    () async {
      final asset = _AsyncAsset(
        () async => const LatLng(latitude: 10.96, longitude: 78.08),
      );
      expect(asset.latitude, isNull);
      final location = await PhotoManagerMediaImportGateway.readCaptureLocation(
        asset,
      );
      expect(location?.latitude, 10.96);
      expect(location?.longitude, 78.08);
    },
  );

  test('unavailable or denied EXIF remains optional', () async {
    for (final asset in [
      _AsyncAsset(() async => null),
      _AsyncAsset(() async => const LatLng(latitude: 0, longitude: 0)),
      _AsyncAsset(
        () async => throw PlatformException(code: 'permission_denied'),
      ),
    ]) {
      expect(
        await PhotoManagerMediaImportGateway.readCaptureLocation(asset),
        isNull,
      );
    }
  });

  group('location import and persistence', () {
    late AppDatabase database;
    late MemorySnapshotRepository repository;
    late ProviderContainer container;
    late _Gallery gallery;
    late _PlaceNames names;

    setUp(() {
      database = AppDatabase.forTesting(NativeDatabase.memory());
      repository = MemorySnapshotRepository(database);
      gallery = _Gallery();
      names = _PlaceNames();
      container = ProviderContainer(
        overrides: [
          appDatabaseProvider.overrideWithValue(database),
          memorySnapshotRepositoryProvider.overrideWithValue(repository),
          mediaImportGatewayProvider.overrideWithValue(gallery),
          placeNameGatewayProvider.overrideWithValue(names),
        ],
      );
    });
    tearDown(() async {
      await repository.load();
      container.dispose();
      await database.close();
    });

    test(
      'scan waits for place names and persists coordinates and graph links',
      () async {
        final response = Completer<String?>();
        names.lookup = (_) => response.future;
        gallery.media = [_photo('one', 10.96, 78.08)];
        final controller = container.read(memoryControllerProvider.notifier);
        final scan = controller.scanGallery();
        await names.started.future;
        expect(
          container.read(memoryControllerProvider).scanState,
          ScanState.scanning,
        );
        expect(
          container
              .read(memoryControllerProvider)
              .events
              .single
              .place
              ?.latitude,
          10.96,
        );
        response.complete('Karur, Tamil Nadu, India');
        await scan;
        final restored = await repository.load();
        expect(restored.events.single.place?.name, 'Karur, Tamil Nadu, India');
        expect(restored.events.single.place?.isConfirmed, isFalse);
        expect(restored.events.single.media.single.longitude, 78.08);
        final nodes = await database.select(database.graphNodes).get();
        expect(
          nodes.where((row) => row.nodeType == 'place').single.label,
          'Karur, Tamil Nadu, India',
        );
        final edges = await database.select(database.graphEdges).get();
        expect(
          edges.where((row) => row.relationType == 'occurred_at'),
          hasLength(1),
        );
        await controller.scanGallery();
        expect(container.read(memoryControllerProvider).events, hasLength(1));
        expect(names.calls, 1);
      },
    );

    test(
      'offline lookup retains coordinates and retries on the next scan',
      () async {
        gallery.media = [_photo('one', 10.96, 78.08)];
        names.lookup = (_) async => throw PlatformException(code: 'IO_ERROR');
        final controller = container.read(memoryControllerProvider.notifier);
        await controller.scanGallery();
        expect(
          container.read(memoryControllerProvider).scanState,
          ScanState.completed,
        );
        expect(
          (await repository.load()).events.single.locationLabel,
          '10.96000° N, 78.08000° E',
        );
        names.lookup = (_) async => 'Karur, Tamil Nadu, India';
        await controller.scanGallery();
        expect(
          (await repository.load()).events.single.place?.name,
          'Karur, Tamil Nadu, India',
        );
      },
    );

    test('slow lookup times out without a late location overwrite', () async {
      gallery.media = [_photo('one', 10.96, 78.08)];
      final response = Completer<String?>();
      names.lookup = (_) => response.future;
      await container.read(memoryControllerProvider.notifier).scanGallery();
      expect(
        container.read(memoryControllerProvider).scanState,
        ScanState.completed,
      );
      final label = container
          .read(memoryControllerProvider)
          .events
          .single
          .locationLabel;
      response.complete('Late place name');
      await Future<void>.delayed(Duration.zero);
      expect(
        container.read(memoryControllerProvider).events.single.locationLabel,
        label,
      );
    });

    test('photos without GPS do not acquire an invented place', () async {
      gallery.media = [_photo('one', 0, 0), _photo('two', null, null)];
      await container.read(memoryControllerProvider.notifier).scanGallery();
      expect(names.calls, 0);
      for (final event in (await repository.load()).events) {
        expect(event.place, isNull);
        expect(event.locationLabel, 'Location unavailable');
      }
    });

    test(
      'legacy imports gain GPS without duplicate events or lost context',
      () async {
        final oldPhoto = _photo('one', null, null);
        await repository.save(
          MemorySnapshot(
            events: [
              _event([oldPhoto]).copyWith(
                title: 'My graduation',
                story: 'A day to remember',
                place: const MemoryPlace(
                  id: 'manual',
                  name: 'College hall',
                  isConfirmed: true,
                ),
              ),
            ],
            unassignedMedia: [_photo('unassigned', null, null)],
          ),
        );
        gallery.media = [
          _photo('one', 10.96, 78.08),
          _photo('unassigned', 13.08, 80.27),
        ];
        final controller = container.read(memoryControllerProvider.notifier);
        // Called immediately: restoration must finish before incremental import.
        await controller.scanGallery();
        var restored = await repository.load();
        expect(restored.events, hasLength(1));
        final event = restored.events.single;
        expect(event.id, 'event-one');
        expect(event.title, 'My graduation');
        expect(event.story, 'A day to remember');
        expect(event.place?.name, 'College hall');
        expect(event.place?.isConfirmed, isTrue);
        expect(event.media.single.ocrText, oldPhoto.ocrText);
        expect(event.media.single.fingerprint, oldPhoto.fingerprint);
        expect(event.media.single.latitude, 10.96);
        expect(restored.unassignedMedia.single.latitude, 13.08);
        expect(
          gallery.refreshIds,
          containsAll(['asset-one', 'asset-unassigned']),
        );
        expect(names.calls, 0);
        await controller.scanGallery();
        restored = await repository.load();
        expect(restored.events, hasLength(1));
        expect(restored.unassignedMedia, hasLength(1));
        expect(gallery.refreshIds, isEmpty);
        final scans = await database.select(database.scanHistory).get();
        expect(scans.every((row) => row.importedCount == 0), isTrue);
      },
    );

    test(
      'existing GPS gets a name even when no new photos are imported',
      () async {
        final media = _photo('one', 10.96, 78.08);
        await repository.save(
          MemorySnapshot(
            events: [
              _event([media]),
            ],
          ),
        );
        gallery.media = [media];
        await container.read(memoryControllerProvider.notifier).scanGallery();
        expect(
          (await repository.load()).events.single.place?.name,
          'Karur, Tamil Nadu, India',
        );
        expect((await database.select(database.events).get()), hasLength(1));
      },
    );

    test('manual edit made during lookup takes precedence', () async {
      gallery.media = [_photo('one', 10.96, 78.08)];
      final response = Completer<String?>();
      names.lookup = (_) => response.future;
      final controller = container.read(memoryControllerProvider.notifier);
      final scan = controller.scanGallery();
      await names.started.future;
      final event = container.read(memoryControllerProvider).events.single;
      controller.saveEventDetails(
        eventId: event.id,
        title: event.title,
        description: 'My story',
        placeName: 'My family home',
      );
      response.complete('Karur');
      await scan;
      expect(
        (await repository.load()).events.single.place?.name,
        'My family home',
      );
    });

    test(
      'split and remove use the remaining photos; merge keeps manual place',
      () async {
        await repository.save(
          MemorySnapshot(
            events: [
              _event([
                _photo('one', 10.96, 78.08),
                _photo('two', 13.08, 80.27),
                _photo('three', null, null),
              ]),
            ],
          ),
        );
        final controller = container.read(memoryControllerProvider.notifier);
        await controller.scanGallery();
        controller.splitEvent('event-one', 1);
        var events = container.read(memoryControllerProvider).events;
        final secondId = events.last.id;
        expect(events.first.place?.latitude, 10.96);
        expect(events.last.place?.latitude, 13.08);
        controller.removeMedia(secondId, 'two');
        expect(controller.eventById(secondId)?.place, isNull);
        controller.addMedia(secondId, 'two');
        expect(controller.eventById(secondId)?.place?.latitude, 13.08);
        controller.saveEventDetails(
          eventId: secondId,
          title: 'Visit',
          description: '',
          placeName: 'Family home',
        );
        controller.mergeEvents(secondId, 'event-one');
        final restored = await repository.load();
        expect(restored.events, hasLength(1));
        expect(restored.events.single.place?.name, 'Family home');
        expect(restored.events.single.media, hasLength(3));
      },
    );
  });

  test(
    'structured geocoding fields survive import and repository reload',
    () async {
      final database = AppDatabase.forTesting(NativeDatabase.memory());
      final repository = MemorySnapshotRepository(database);
      final gallery = _Gallery()..media = [_photo('address', 10.96, 78.08)];
      final container = ProviderContainer(
        overrides: [
          appDatabaseProvider.overrideWithValue(database),
          memorySnapshotRepositoryProvider.overrideWithValue(repository),
          mediaImportGatewayProvider.overrideWithValue(gallery),
          placeNameGatewayProvider.overrideWithValue(_Addresses()),
        ],
      );
      addTearDown(() async {
        container.dispose();
        await database.close();
      });
      await container.read(memoryControllerProvider.notifier).scanGallery();
      final place = (await repository.load()).events.single.place!;
      expect(place.city, 'Karur');
      expect(place.locality, 'College area');
      expect(place.region, 'Tamil Nadu');
      expect(place.country, 'India');
      expect(place.formattedAddress, 'College area, Karur, Tamil Nadu, India');
    },
  );
}

class _Addresses implements DetailedPlaceNameGateway {
  @override
  Future<PlaceAddress?> addressFor(CaptureLocation location) async =>
      const PlaceAddress(
        label: 'Karur, Tamil Nadu, India',
        locality: 'College area',
        city: 'Karur',
        region: 'Tamil Nadu',
        country: 'India',
        formattedAddress: 'College area, Karur, Tamil Nadu, India',
      );
  @override
  Future<String?> nameFor(CaptureLocation location) async =>
      (await addressFor(location))?.label;
}

MediaItem _photo(String id, double? latitude, double? longitude) => MediaItem(
  id: id,
  assetIdentifier: 'asset-$id',
  kind: MediaKind.image,
  capturedAt: DateTime.utc(2026, 8, 1, 10),
  width: 1200,
  height: 900,
  latitude: latitude,
  longitude: longitude,
  ocrText: 'Graduation ceremony',
  fingerprint: 'saved-fingerprint-$id',
);

MemoryEvent _event(List<MediaItem> media) => MemoryEvent(
  id: 'event-one',
  title: 'Graduation',
  startAt: media.first.capturedAt,
  endAt: media.last.capturedAt,
  media: media,
  people: const [],
  scores: const MemoryScores(
    significance: 0.5,
    rediscoveryRisk: 0.5,
    contextCompleteness: 0,
    preservationNeed: 0.25,
  ),
);

class _AsyncAsset extends AssetEntity {
  _AsyncAsset(this.read)
    : super(id: 'asset', typeInt: 1, width: 10, height: 10);
  final Future<LatLng?> Function() read;
  @override
  Future<LatLng?> latlngAsync() => read();
}

class _Gallery implements MediaImportGateway {
  List<MediaItem> media = [];
  Set<String> refreshIds = {};
  @override
  Future<GalleryAccess> currentAccess() async => GalleryAccess.full;
  @override
  Future<GalleryAccess> requestAccess() => currentAccess();
  @override
  Future<void> openLimitedSelection() async {}
  @override
  Future<List<MediaItem>> scan({
    Set<String> knownAssetIdentifiers = const {},
    Set<String> refreshLocationAssetIdentifiers = const {},
    void Function(MediaScanProgress)? onProgress,
  }) async {
    refreshIds = refreshLocationAssetIdentifiers;
    onProgress?.call(
      MediaScanProgress(
        processed: media.length,
        total: media.length,
        currentStage: 'Reading metadata',
      ),
    );
    return media
        .where(
          (item) =>
              !knownAssetIdentifiers.contains(item.assetIdentifier) ||
              refreshLocationAssetIdentifiers.contains(item.assetIdentifier),
        )
        .toList();
  }
}

class _PlaceNames implements PlaceNameGateway {
  int calls = 0;
  final started = Completer<void>();
  Future<String?> Function(CaptureLocation) lookup = (_) async =>
      'Karur, Tamil Nadu, India';
  @override
  Future<String?> nameFor(CaptureLocation location) {
    calls++;
    if (!started.isCompleted) started.complete();
    return lookup(location);
  }
}
