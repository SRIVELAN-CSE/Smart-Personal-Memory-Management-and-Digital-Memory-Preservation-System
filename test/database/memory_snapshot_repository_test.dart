import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_memory_preservation/core/database/app_database.dart';
import 'package:smart_memory_preservation/core/database/demo_seed_repository.dart';
import 'package:smart_memory_preservation/core/database/memory_snapshot_repository.dart';
import 'package:smart_memory_preservation/core/models/memory_models.dart';

void main() {
  late AppDatabase database;
  late MemorySnapshotRepository repository;

  setUp(() {
    database = AppDatabase.forTesting(NativeDatabase.memory());
    repository = MemorySnapshotRepository(
      database,
      clock: () => DateTime.utc(2026, 8, 31, 12),
    );
  });

  tearDown(() => database.close());

  test(
    'normalized snapshot round-trips context, scores and feedback',
    () async {
      await DemoSeedRepository(database).ensureSeeded();
      final media = _media('media-real-one', 'asset-real-one', 9);
      final unassigned = _media('media-real-two', 'asset-real-two', 10);
      final event = MemoryEvent(
        id: 'event-real',
        title: 'Confirmed review',
        startAt: media.capturedAt,
        endAt: media.capturedAt,
        media: [media],
        people: const [MemoryPerson(id: 'person-real', name: 'Asha')],
        place: const MemoryPlace(
          id: 'place-real',
          name: 'Campus hall',
          isConfirmed: true,
        ),
        description: 'A short event description.',
        story: 'The personal story behind the review.',
        voiceNotePath: r'C:\app-private\review.m4a',
        coverMediaId: media.id,
        rating: 5,
        isFavourite: true,
        isImportant: true,
        titleOrigin: ContentOrigin.userConfirmed,
        titleConfirmed: true,
        coverConfirmed: true,
        viewCount: 3,
        lastViewedAt: DateTime.utc(2026, 8, 30),
        correctionCount: 2,
        scores: const MemoryScores(
          significance: 0.8,
          rediscoveryRisk: 0.7,
          contextCompleteness: 0.6,
          preservationNeed: 0.224,
          significanceFactors: [
            ScoreFactor(
              label: 'Manual rating',
              normalizedValue: 1,
              weight: 0.35,
              contribution: 0.35,
              explanation: 'Five-star rating.',
            ),
          ],
        ),
      );
      final recommendation = PreservationRecommendation(
        id: 'recommendation-real',
        eventId: event.id,
        title: 'Future revisit',
        explanation: 'High significance and high rediscovery risk.',
        primaryAction: RecommendationAction.timeCapsule,
        status: RecommendationStatus.completed,
        createdAt: DateTime.utc(2026, 8, 31, 10),
        scheduledFor: DateTime.utc(2027, 8, 31, 10),
        feedback: RecommendationFeedback.helpful,
      );

      await repository.save(
        MemorySnapshot(
          events: [event],
          recommendations: [recommendation],
          unassignedMedia: [unassigned],
        ),
      );
      final restored = await repository.load();

      expect(restored.events, hasLength(1));
      final restoredEvent = restored.events.single;
      expect(restoredEvent.title, 'Confirmed review');
      expect(restoredEvent.description, 'A short event description.');
      expect(restoredEvent.story, 'The personal story behind the review.');
      expect(restoredEvent.voiceNotePath, r'C:\app-private\review.m4a');
      expect(restoredEvent.people.single.name, 'Asha');
      expect(restoredEvent.place?.name, 'Campus hall');
      expect(restoredEvent.correctionCount, 2);
      expect(restoredEvent.scores.significance, closeTo(0.8, 0.000001));
      expect(
        restoredEvent.scores.significanceFactors.single.label,
        'Manual rating',
      );
      expect(restored.unassignedMedia.single.assetIdentifier, 'asset-real-two');

      expect(restored.recommendations, hasLength(1));
      final restoredRecommendation = restored.recommendations.single;
      expect(restoredRecommendation.status, RecommendationStatus.completed);
      expect(restoredRecommendation.feedback, RecommendationFeedback.helpful);
      expect(
        restoredRecommendation.scheduledFor?.toUtc(),
        DateTime.utc(2027, 8, 31, 10),
      );

      expect(await database.select(database.notes).get(), hasLength(1));
      expect(await database.select(database.voiceNotes).get(), hasLength(1));
      expect(await database.select(database.reminders).get(), hasLength(1));
      expect(await database.select(database.userFeedback).get(), hasLength(1));
      expect(await database.select(database.graphNodes).get(), hasLength(29));
      expect(await database.select(database.mediaItems).get(), hasLength(20));
      expect(
        (await database.select(database.mediaItems).get())
            .where((row) => !row.isDemo)
            .every((row) => row.visualEmbedding == null),
        isTrue,
      );
    },
  );

  test('snapshot replacement is atomic and retains scan audit rows', () async {
    final scanId = await repository.beginScan(permissionMode: 'limited');
    await repository.completeScan(
      scanId: scanId,
      discoveredCount: 2,
      importedCount: 2,
      skippedCount: 0,
    );
    final first = _media('media-one', 'asset-one', 9);
    final second = _media('media-two', 'asset-two', 10);
    await repository.save(
      MemorySnapshot(
        events: [
          _event('event-one', [first]),
        ],
        unassignedMedia: [second],
      ),
    );
    await repository.save(
      MemorySnapshot(
        events: [
          _event('event-one', [first, second]),
        ],
      ),
    );

    final restored = await repository.load();
    expect(restored.events.single.media, hasLength(2));
    expect(restored.unassignedMedia, isEmpty);
    expect(await database.select(database.events).get(), hasLength(1));
    expect(await database.select(database.mediaItems).get(), hasLength(2));
    expect(await database.select(database.eventMedia).get(), hasLength(2));
    expect(await database.select(database.scanHistory).get(), hasLength(1));
  });

  test(
    'derived-data deletion keeps privacy preferences and foreign keys on',
    () async {
      await DemoSeedRepository(database).ensureSeeded();
      await repository.beginScan(permissionMode: 'full');

      await repository.deleteAllDerivedData();

      expect(await database.select(database.events).get(), isEmpty);
      expect(await database.select(database.mediaItems).get(), isEmpty);
      expect(await database.select(database.graphNodes).get(), isEmpty);
      expect(await database.select(database.scanHistory).get(), isEmpty);
      expect(
        await database.select(database.privacySettings).get(),
        hasLength(1),
      );
      final foreignKeys = await database
          .customSelect('PRAGMA foreign_keys;')
          .getSingle();
      expect(foreignKeys.read<int>('foreign_keys'), 1);
    },
  );
}

MediaItem _media(String id, String assetId, int hour) => MediaItem(
  id: id,
  assetIdentifier: assetId,
  kind: MediaKind.image,
  capturedAt: DateTime.utc(2026, 8, 1, hour),
  width: 1600,
  height: 1200,
  fileSize: 4096,
  ocrText: 'Review hall',
  fingerprint: 'fingerprint-$id',
);

MemoryEvent _event(String id, List<MediaItem> media) => MemoryEvent(
  id: id,
  title: 'Generated event',
  startAt: media.first.capturedAt,
  endAt: media.last.capturedAt,
  media: media,
  people: const [],
  scores: const MemoryScores(
    significance: 0.2,
    rediscoveryRisk: 0.4,
    contextCompleteness: 0,
    preservationNeed: 0.08,
  ),
);
