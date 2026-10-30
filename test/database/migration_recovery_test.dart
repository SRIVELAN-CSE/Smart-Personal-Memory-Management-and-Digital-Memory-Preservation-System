import 'dart:io';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_memory_preservation/core/database/app_database.dart';
import 'package:smart_memory_preservation/core/database/memory_snapshot_repository.dart';
import '../support/library_fixture.dart';

void main() {
  late Directory directory;
  late File file;
  setUp(() async {
    directory = await Directory.systemTemp.createTemp(
      'smart_memory_migration_',
    );
    file = File('${directory.path}/library.sqlite');
  });
  tearDown(() => directory.delete(recursive: true));

  for (final version in [1, 2, 3]) {
    test(
      'schema $version upgrades with saved photos and context intact',
      () async {
        final old = _HistoricalDatabase(file, version);
        final repository = MemorySnapshotRepository(old);
        await repository.save(libraryFixture());
        await repository.beginScan(permissionMode: 'full');
        await old.customStatement(
          "ALTER TABLE events ADD COLUMN legacy_context TEXT",
        );
        await old.customStatement(
          "UPDATE events SET legacy_context = 'keep this too'",
        );
        if (version == 3) {
          await old.customStatement(
            'ALTER TABLE media_items DROP COLUMN location_checked',
          );
          for (final column in [
            'locality',
            'city',
            'state',
            'country',
            'formatted_address',
          ]) {
            await old.customStatement('ALTER TABLE places DROP COLUMN $column');
          }
        }
        await old.close();
        var current = AppDatabase.forTesting(NativeDatabase(file));
        var restored = await MemorySnapshotRepository(current).load();
        final event = restored.events.single;
        expect(event.title, 'Saved gallery memory');
        expect(event.media, hasLength(3));
        expect(event.media.first.latitude, 10.96);
        expect(event.story, 'Keep this personal story.');
        expect(event.people.single.name, 'Asha');
        expect(event.place?.name, 'Campus hall');
        expect(event.voiceNotePath, '/app-private/saved.m4a');
        expect(event.isFavourite, isTrue);
        expect(event.rating, 5);
        expect(event.scores.significance, .8);
        expect(
          restored.recommendations.single.scheduledFor?.toUtc(),
          DateTime.utc(2028, 8, 1),
        );
        expect(await current.select(current.scanHistory).get(), hasLength(1));
        expect(
          (await current
                  .customSelect('SELECT legacy_context FROM events')
                  .getSingle())
              .read<String>('legacy_context'),
          'keep this too',
        );
        expect(
          (await current.customSelect('PRAGMA user_version').getSingle())
              .read<int>('user_version'),
          smartMemorySchemaVersion,
        );
        expect(
          await current.customSelect('PRAGMA foreign_key_check').get(),
          isEmpty,
        );
        await current.close();
        current = AppDatabase.forTesting(NativeDatabase(file));
        restored = await MemorySnapshotRepository(current).load();
        expect(restored.events.single.media, hasLength(3));
        await current.close();
      },
    );
  }

  test('schema 2 fills missing optional columns, tables and indexes', () async {
    final old = _HistoricalDatabase(file, 2);
    await MemorySnapshotRepository(old).save(libraryFixture());
    await old.customStatement('ALTER TABLE events DROP COLUMN description');
    await old.customStatement('DROP TABLE processing_jobs');
    await old.customStatement('DROP INDEX media_items_capture_at_idx');
    await old.close();
    final current = AppDatabase.forTesting(NativeDatabase(file));
    final restored = await MemorySnapshotRepository(current).load();
    expect(restored.events.single.description, isNull);
    expect(restored.events.single.story, 'Keep this personal story.');
    expect(await current.select(current.processingJobs).get(), isEmpty);
    expect(
      await current
          .customSelect(
            "SELECT name FROM sqlite_master WHERE name = 'media_items_capture_at_idx'",
          )
          .get(),
      hasLength(1),
    );
    await current.close();
  });

  test(
    'incompatible schema fails without erasing saved rows or changing version',
    () async {
      final old = _HistoricalDatabase(file, 2);
      await MemorySnapshotRepository(old).save(libraryFixture());
      await old.customStatement('ALTER TABLE events DROP COLUMN description');
      await old.customStatement(
        'ALTER TABLE events DROP COLUMN generated_title',
      );
      await old.close();
      final current = AppDatabase.forTesting(NativeDatabase(file));
      await expectLater(
        MemorySnapshotRepository(current).load(),
        throwsStateError,
      );
      await current.close();
      final inspect = _HistoricalDatabase(file, 2);
      expect(
        (await inspect
                .customSelect('SELECT COUNT(*) AS n FROM media_items')
                .getSingle())
            .read<int>('n'),
        3,
      );
      expect(
        (await inspect.customSelect('PRAGMA user_version').getSingle())
            .read<int>('user_version'),
        2,
      );
      final columns = await inspect
          .customSelect('PRAGMA table_info(events)')
          .get();
      expect(
        columns.map((row) => row.read<String>('name')),
        isNot(contains('description')),
      );
      await inspect.close();
    },
  );

  test('newer unknown schema is rejected and preserved', () async {
    final old = _HistoricalDatabase(file, 5);
    await MemorySnapshotRepository(old).save(libraryFixture());
    await old.close();
    final current = AppDatabase.forTesting(NativeDatabase(file));
    await expectLater(
      MemorySnapshotRepository(current).load(),
      throwsStateError,
    );
    await current.close();
    final inspect = _HistoricalDatabase(file, 5);
    expect(
      (await MemorySnapshotRepository(inspect).load()).events.single.media,
      hasLength(3),
    );
    await inspect.close();
  });

  test(
    'explicit deletion removes migration backup before library rows',
    () async {
      final backup = File('${directory.path}/backup.sqlite');
      await backup.writeAsString('private backup');
      final current = AppDatabase.forTesting(
        NativeDatabase(file),
        deleteMigrationBackup: backup.delete,
      );
      final repository = MemorySnapshotRepository(current);
      await repository.save(libraryFixture());
      await repository.deleteAllDerivedData();
      expect(await backup.exists(), isFalse);
      expect((await repository.load()).events, isEmpty);
      await current.close();
    },
  );
}

// The shipped v1 table layout is unchanged. v2 variants above model additive
// differences because the user's original v2 APK/database is not available.
class _HistoricalDatabase extends AppDatabase {
  _HistoricalDatabase(File file, this.version)
    : super.forTesting(NativeDatabase(file));
  final int version;
  @override
  int get schemaVersion => version;
}
