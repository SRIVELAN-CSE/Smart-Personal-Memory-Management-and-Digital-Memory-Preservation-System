import 'dart:async';
import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_memory_preservation/core/database/app_database.dart';
import 'package:smart_memory_preservation/core/database/memory_snapshot_repository.dart';
import 'package:smart_memory_preservation/core/models/memory_models.dart';
import 'package:smart_memory_preservation/features/event_management/presentation/memory_controller.dart';
import 'package:smart_memory_preservation/features/media_import/domain/media_import_gateway.dart';
import '../support/library_fixture.dart';

void main() {
  late AppDatabase database;
  late _FailingRepository repository;
  late _Gateway gateway;
  late ProviderContainer container;
  late MemoryController controller;
  setUp(() async {
    database = AppDatabase.forTesting(NativeDatabase.memory());
    repository = _FailingRepository(database);
    await repository.save(libraryFixture());
    gateway = _Gateway();
    container = ProviderContainer(
      overrides: [
        appDatabaseProvider.overrideWithValue(database),
        memorySnapshotRepositoryProvider.overrideWithValue(repository),
        mediaImportGatewayProvider.overrideWithValue(gateway),
      ],
    );
    controller = container.read(memoryControllerProvider.notifier);
  });
  tearDown(() async {
    await repository.drain();
    container.dispose();
    await database.close();
  });

  test(
    'restore errors are visible and block scans and overwrites; retry recovers',
    () async {
      repository.failLoad = true;
      await controller.ensureRestored();
      expect(container.read(memoryControllerProvider).restoreFailed, isTrue);
      await controller.scanGallery();
      await controller.enableDemoMode();
      controller.renameEvent('saved_event', 'Do not overwrite');
      expect(gateway.scans, 0);
      expect(
        container.read(memoryControllerProvider).errorMessage,
        contains('not been deleted'),
      );
      repository.failLoad = false;
      await controller.retryRestore();
      expect(container.read(memoryControllerProvider).restoreFailed, isFalse);
      expect(
        controller.eventById('saved_event')?.title,
        'Saved gallery memory',
      );
    },
  );

  test('save errors keep edits in memory and retry persists them', () async {
    await controller.ensureRestored();
    repository.failSave = true;
    controller.renameEvent('saved_event', 'An edited title');
    await Future<void>.delayed(Duration.zero);
    expect(container.read(memoryControllerProvider).saveFailed, isTrue);
    expect(controller.eventById('saved_event')?.title, 'An edited title');
    repository.failSave = false;
    await controller.retrySave();
    expect(container.read(memoryControllerProvider).saveFailed, isFalse);
    expect((await repository.load()).events.single.title, 'An edited title');
  });

  test(
    'denied gallery access preserves saved library and does not scan',
    () async {
      await controller.ensureRestored();
      gateway.access = GalleryAccess.denied;
      await controller.scanGallery();
      expect(gateway.scans, 0);
      expect(
        container.read(memoryControllerProvider).scanState,
        ScanState.failed,
      );
      expect(controller.eventById('saved_event')?.media, hasLength(3));
      expect((await repository.load()).events, hasLength(1));
    },
  );

  test('demo never replaces a real saved library', () async {
    await controller.enableDemoMode();
    expect(container.read(memoryControllerProvider).demoMode, isFalse);
    expect(controller.eventById('saved_event'), isNotNull);
  });

  test(
    'editing, membership, split, merge, context and feedback persist together',
    () async {
      await controller.ensureRestored();
      controller.saveEventDetails(
        eventId: 'saved_event',
        title: 'Revised memory',
        description: 'New description',
        placeName: 'Karur',
      );
      controller.saveStory('saved_event', 'Our new story');
      controller.attachVoiceNote('saved_event', '/app-private/replacement.m4a');
      controller.saveMediaText(
        'saved_event',
        'saved_photo_0',
        'Accurate text from original',
      );
      controller.addPerson('saved_event', 'Ravi');
      controller.addPerson('saved_event', 'ravi');
      controller.selectCover('saved_event', 'saved_photo_1');
      controller.setRating('saved_event', 4);
      controller.toggleFavourite('saved_event');
      controller.toggleImportant('saved_event');
      controller.markViewed('saved_event');
      controller.removeMedia('saved_event', 'saved_photo_2');
      expect(
        container.read(memoryControllerProvider).unassignedMedia,
        hasLength(1),
      );
      controller.addMedia('saved_event', 'saved_photo_2');
      controller.splitEvent('saved_event', 1);
      final second = container.read(memoryControllerProvider).events.last;
      controller.mergeEvents('saved_event', second.id);
      controller.submitRecommendationFeedback(
        'saved_recommendation',
        RecommendationFeedback.notHelpful,
      );
      controller.scheduleTimeCapsule(
        'saved_recommendation',
        DateTime.utc(2029, 1, 1),
      );
      await controller.retrySave();
      final restored = await repository.load();
      final event = restored.events.single;
      expect(event.title, 'Revised memory');
      expect(event.story, 'Our new story');
      expect(event.voiceNotePath, '/app-private/replacement.m4a');
      expect(event.media.first.ocrText, 'Accurate text from original');
      expect(event.description, 'New description');
      expect(event.place?.name, 'Karur');
      expect(event.people.map((p) => p.name), ['Asha', 'Ravi']);
      expect(event.media, hasLength(3));
      expect(
        event.coverMediaId,
        'saved_photo_0',
      ); // Split removed the old cover from this half.
      expect(event.rating, 4);
      expect(event.isFavourite, isFalse);
      expect(event.isImportant, isFalse);
      expect(event.viewCount, 1);
      expect(
        restored.recommendations.single.feedback,
        RecommendationFeedback.notHelpful,
      );
      expect(
        restored.recommendations.single.scheduledFor?.toUtc(),
        DateTime.utc(2029, 1, 1),
      );
      expect(
        await database.customSelect('PRAGMA foreign_key_check').get(),
        isEmpty,
      );
      controller.setSensitive('saved_event', true);
      await controller.retrySave();
      expect((await repository.load()).recommendations, isEmpty);
      expect(
        (await repository.load()).events.single.sensitivity,
        SensitivityLevel.hidden,
      );
      controller.deleteEvent('saved_event');
      await controller.retrySave();
      expect((await repository.load()).events, isEmpty);
      expect((await repository.load()).unassignedMedia, hasLength(3));
    },
  );

  test('failed deletion retains visible and persisted memories', () async {
    await controller.ensureRestored();
    repository.failDelete = true;
    expect(await controller.deleteAllDerivedData(), isFalse);
    expect(container.read(memoryControllerProvider).events, hasLength(1));
    expect((await repository.load()).events, hasLength(1));
  });

  test(
    'deleting during a scan prevents late results from restoring deleted data',
    () async {
      await controller.ensureRestored();
      gateway.pending = Completer<List<MediaItem>>();
      final scan = controller.scanGallery();
      await gateway.started.future;
      expect(await controller.deleteAllDerivedData(), isTrue);
      gateway.pending!.complete(libraryFixture().events.single.media);
      await scan;
      expect(container.read(memoryControllerProvider).events, isEmpty);
      expect((await repository.load()).events, isEmpty);
      expect(await database.select(database.scanHistory).get(), isEmpty);
    },
  );
}

class _FailingRepository extends MemorySnapshotRepository {
  _FailingRepository(super.database);
  bool failLoad = false, failSave = false, failDelete = false;
  @override
  Future<MemorySnapshot> load() async {
    if (failLoad) throw StateError('simulated read failure');
    return super.load();
  }

  @override
  Future<void> save(MemorySnapshot snapshot) async {
    if (failSave) throw StateError('simulated full disk');
    await super.save(snapshot);
  }

  @override
  Future<void> deleteAllDerivedData() async {
    if (failDelete) throw StateError('simulated delete failure');
    await super.deleteAllDerivedData();
  }

  Future<void> drain() async {
    await super.load();
  }
}

class _Gateway implements MediaImportGateway {
  GalleryAccess access = GalleryAccess.full;
  int scans = 0;
  Completer<List<MediaItem>>? pending;
  final started = Completer<void>();
  @override
  Future<GalleryAccess> currentAccess() async => access;
  @override
  Future<GalleryAccess> requestAccess() async => access;
  @override
  Future<void> openLimitedSelection() async {}
  @override
  Future<List<MediaItem>> scan({
    Set<String> knownAssetIdentifiers = const {},
    Set<String> refreshLocationAssetIdentifiers = const {},
    void Function(MediaScanProgress)? onProgress,
  }) async {
    scans++;
    if (!started.isCompleted) started.complete();
    return pending == null ? [] : await pending!.future;
  }
}
