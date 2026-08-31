import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_memory_preservation/core/database/app_database.dart';
import 'package:smart_memory_preservation/core/database/demo_seed_repository.dart';
import 'package:smart_memory_preservation/core/database/memory_database_repository.dart';

void main() {
  late AppDatabase database;
  late DemoSeedRepository demoSeed;

  setUp(() {
    database = AppDatabase.forTesting(NativeDatabase.memory());
    demoSeed = DemoSeedRepository(database);
  });

  tearDown(() async {
    await database.close();
  });

  test('schema version starts at one and enables foreign keys', () async {
    expect(database.schemaVersion, smartMemorySchemaVersion);

    final result = await database
        .customSelect('PRAGMA foreign_keys;')
        .getSingle();
    expect(result.read<int>('foreign_keys'), 1);
  });

  test('version one creates important query indexes', () async {
    await database.customSelect('SELECT 1;').getSingle();
    final rows = await database
        .customSelect(
          "SELECT name FROM sqlite_master WHERE type = 'index' "
          "AND name IN ("
          "'media_items_capture_at_idx', "
          "'event_media_event_position_idx', "
          "'recommendations_status_created_idx', "
          "'processing_jobs_status_retry_idx'"
          ') ORDER BY name;',
        )
        .get();

    expect(rows.map((row) => row.read<String>('name')).toSet(), {
      'media_items_capture_at_idx',
      'event_media_event_position_idx',
      'recommendations_status_created_idx',
      'processing_jobs_status_retry_idx',
    });
  });

  test('demo seed is complete and idempotent', () async {
    final first = await demoSeed.ensureSeeded();
    final second = await demoSeed.ensureSeeded();

    expect(first.inserted, isTrue);
    expect(first.mediaCount, DemoSeedRepository.demoMediaCount);
    expect(second.inserted, isFalse);
    expect(second.mediaCount, DemoSeedRepository.demoMediaCount);

    final event =
        await (database.select(database.events)
              ..where((row) => row.id.equals(DemoSeedRepository.demoEventId)))
            .getSingle();
    expect(event.confirmedTitle, 'Final-Year Project Review');
    expect(event.manualRating, 5);
    expect(event.isFavourite, isTrue);
    expect(event.isSensitive, isFalse);

    expect(await database.select(database.mediaItems).get(), hasLength(18));
    expect(await database.select(database.eventMedia).get(), hasLength(18));
    expect(await database.select(database.eventPersons).get(), hasLength(2));
    expect(await database.select(database.mediaPersons).get(), hasLength(2));
    expect(await database.select(database.notes).get(), isEmpty);
    expect(await database.select(database.voiceNotes).get(), isEmpty);
    expect(await database.select(database.graphNodes).get(), hasLength(22));
    expect(await database.select(database.graphEdges).get(), hasLength(21));

    final significance = await database
        .select(database.significanceScores)
        .getSingle();
    final rediscovery = await database
        .select(database.rediscoveryScores)
        .getSingle();
    final context = await database.select(database.contextScores).getSingle();
    expect(significance.score, DemoSeedRepository.demoSignificance);
    expect(rediscovery.score, DemoSeedRepository.demoRediscoveryRisk);
    expect(context.score, DemoSeedRepository.demoContextCompleteness);
    expect(significance.isIllustrative, isTrue);

    final recommendation = await database
        .select(database.preservationRecommendations)
        .getSingle();
    expect(
      recommendation.explanation,
      DemoSeedRepository.demoRecommendationText,
    );
  });

  test('foreign keys reject orphan event-media memberships', () async {
    await expectLater(
      database
          .into(database.eventMedia)
          .insert(
            EventMediaCompanion.insert(
              eventId: 'missing-event',
              mediaId: 'missing-media',
            ),
          ),
      throwsA(anything),
    );
  });

  test(
    'recording a view updates the event and stores the interaction',
    () async {
      await demoSeed.ensureSeeded();
      final repository = MemoryDatabaseRepository(
        database,
        clock: () => DateTime.utc(2026, 8, 31, 9),
      );

      await repository.recordEventView(
        eventId: DemoSeedRepository.demoEventId,
        interactionId: 'test-view-interaction',
      );

      final event = await repository.getEvent(DemoSeedRepository.demoEventId);
      expect(event, isNotNull);
      expect(event!.viewCount, 2);
      // Drift materializes epoch timestamps in the host's local time zone;
      // compare the represented instant in UTC.
      expect(event.lastViewedAt?.toUtc(), DateTime.utc(2026, 8, 31, 9));

      final interactions = await (database.select(
        database.eventInteractions,
      )..where((row) => row.id.equals('test-view-interaction'))).get();
      expect(interactions, hasLength(1));
    },
  );

  test('derived event deletion retains gallery media references', () async {
    await demoSeed.ensureSeeded();
    final repository = MemoryDatabaseRepository(database);

    expect(
      await repository.deleteDerivedEvent(DemoSeedRepository.demoEventId),
      isTrue,
    );
    expect(await database.select(database.events).get(), isEmpty);
    expect(await database.select(database.eventMedia).get(), isEmpty);
    expect(await database.select(database.significanceScores).get(), isEmpty);
    expect(
      await database.select(database.preservationRecommendations).get(),
      isEmpty,
    );
    expect(await database.select(database.eventInteractions).get(), isEmpty);
    expect(await database.select(database.graphEdges).get(), isEmpty);
    expect(await database.select(database.mediaItems).get(), hasLength(18));
  });
}
