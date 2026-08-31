import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_memory_preservation/core/database/app_database.dart';
import 'package:smart_memory_preservation/core/database/memory_snapshot_repository.dart';
import 'package:smart_memory_preservation/core/models/memory_models.dart';
import 'package:smart_memory_preservation/features/event_management/presentation/memory_controller.dart';
import 'package:smart_memory_preservation/features/media_import/domain/media_import_gateway.dart';

void main() {
  test('permission denial is safe and keeps demo mode available', () async {
    final database = AppDatabase.forTesting(NativeDatabase.memory());
    final container = ProviderContainer(
      overrides: [
        appDatabaseProvider.overrideWithValue(database),
        mediaImportGatewayProvider.overrideWithValue(
          _FakeMediaImportGateway(access: GalleryAccess.denied),
        ),
      ],
    );
    addTearDown(() async {
      container.dispose();
      await database.close();
    });

    final result = await container
        .read(memoryControllerProvider.notifier)
        .requestGalleryAccess();

    expect(result, GalleryAccess.denied);
    expect(container.read(memoryControllerProvider).events, isEmpty);
    expect(container.read(memoryControllerProvider).scanState, ScanState.idle);
  });

  test('an empty selected gallery completes without creating events', () async {
    final database = AppDatabase.forTesting(NativeDatabase.memory());
    final container = ProviderContainer(
      overrides: [
        appDatabaseProvider.overrideWithValue(database),
        mediaImportGatewayProvider.overrideWithValue(
          _FakeMediaImportGateway(access: GalleryAccess.full),
        ),
      ],
    );
    addTearDown(() async {
      container.dispose();
      await database.close();
    });

    await container.read(memoryControllerProvider.notifier).scanGallery();

    final state = container.read(memoryControllerProvider);
    expect(state.scanState, ScanState.completed);
    expect(state.scanProgress, 1);
    expect(state.scanStage, 'No new media found');
    expect(state.events, isEmpty);
    final scans = await database.select(database.scanHistory).get();
    expect(scans, hasLength(1));
    expect(scans.single.status, 'completed');
  });

  test(
    'real scan state is persisted and a repeat scan is idempotent',
    () async {
      final database = AppDatabase.forTesting(NativeDatabase.memory());
      final gateway = _FakeMediaImportGateway(
        access: GalleryAccess.full,
        media: [
          MediaItem(
            id: 'media-one',
            assetIdentifier: 'asset-one',
            kind: MediaKind.image,
            capturedAt: DateTime.utc(2026, 8, 1, 9),
            width: 1200,
            height: 900,
            fileSize: 2048,
            ocrText: 'Project review',
            fingerprint: 'fingerprint-one',
          ),
          MediaItem(
            id: 'media-two',
            assetIdentifier: 'asset-two',
            kind: MediaKind.image,
            capturedAt: DateTime.utc(2026, 8, 1, 10),
            width: 1200,
            height: 900,
            fileSize: 4096,
            ocrText: 'Project review',
            fingerprint: 'fingerprint-two',
          ),
        ],
      );
      final container = ProviderContainer(
        overrides: [
          appDatabaseProvider.overrideWithValue(database),
          mediaImportGatewayProvider.overrideWithValue(gateway),
        ],
      );
      addTearDown(() async {
        container.dispose();
        await database.close();
      });

      final controller = container.read(memoryControllerProvider.notifier);
      await controller.scanGallery();
      await controller.scanGallery();

      final state = container.read(memoryControllerProvider);
      expect(state.events, hasLength(1));
      expect(state.events.single.media, hasLength(2));
      expect(
        gateway.lastKnownAssetIdentifiers,
        containsAll(['asset-one', 'asset-two']),
      );
      expect(await database.select(database.mediaItems).get(), hasLength(2));
      expect(await database.select(database.scanHistory).get(), hasLength(2));

      final restored = await MemorySnapshotRepository(database).load();
      expect(restored.events, hasLength(1));
      expect(restored.events.single.media, hasLength(2));
      expect(restored.events.single.scores.significanceFactors, isNotEmpty);
    },
  );
}

class _FakeMediaImportGateway implements MediaImportGateway {
  _FakeMediaImportGateway({required this.access, this.media = const []});

  final GalleryAccess access;
  final List<MediaItem> media;
  Set<String> lastKnownAssetIdentifiers = const {};

  @override
  Future<GalleryAccess> currentAccess() async => access;

  @override
  Future<void> openLimitedSelection() async {}

  @override
  Future<GalleryAccess> requestAccess() async => access;

  @override
  Future<List<MediaItem>> scan({
    Set<String> knownAssetIdentifiers = const {},
    void Function(MediaScanProgress progress)? onProgress,
  }) async {
    lastKnownAssetIdentifiers = Set.unmodifiable(knownAssetIdentifiers);
    onProgress?.call(
      MediaScanProgress(
        processed: 0,
        total: media.length,
        currentStage: media.isEmpty
            ? 'No selected photos or videos found'
            : 'Read selected photos and videos',
      ),
    );
    return media
        .where((item) => !knownAssetIdentifiers.contains(item.assetIdentifier))
        .toList();
  }
}
