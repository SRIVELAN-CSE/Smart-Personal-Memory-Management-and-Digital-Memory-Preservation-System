import 'package:drift/drift.dart';

import 'database_connection.dart';
import 'tables.dart';

part 'app_database.g.dart';

const smartMemorySchemaVersion = 4;

@DriftDatabase(
  tables: [
    ScanHistory,
    MediaItems,
    Places,
    Events,
    EventMedia,
    Persons,
    EventPersons,
    MediaPersons,
    Notes,
    VoiceNotes,
    GraphNodes,
    GraphEdges,
    SignificanceScores,
    RediscoveryScores,
    ContextScores,
    PreservationRecommendations,
    Reminders,
    UserFeedback,
    PrivacySettings,
    EventInteractions,
    ProcessingJobs,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase.production()
    : _deleteMigrationBackup = deleteSmartMemoryMigrationBackup,
      super(openSmartMemoryDatabase());

  AppDatabase.forTesting(
    super.executor, {
    Future<void> Function()? deleteMigrationBackup,
  }) : _deleteMigrationBackup = deleteMigrationBackup;

  final Future<void> Function()? _deleteMigrationBackup;

  Future<void> deleteMigrationBackup() async {
    // Open first so a lazy migration cannot recreate the backup after deletion.
    await customSelect('SELECT 1').get();
    await _deleteMigrationBackup?.call();
  }

  @override
  int get schemaVersion => smartMemorySchemaVersion;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (migrator) async {
      // Fresh installs create the complete current schema and indexes.
      await migrator.createAll();
    },
    onUpgrade: (migrator, from, to) async {
      if (from < 1 || from > 3 || to != 4) {
        throw StateError(
          'This library uses database version $from. Install a compatible '
          'Smart Memory update. Your saved data has not been reset.',
        );
      }
      if (from == 3) {
        await transaction(() async {
          await migrator.addColumn(mediaItems, mediaItems.locationChecked);
          await migrator.addColumn(places, places.locality);
          await migrator.addColumn(places, places.city);
          await migrator.addColumn(places, places.state);
          await migrator.addColumn(places, places.country);
          await migrator.addColumn(places, places.formattedAddress);
        });
        return;
      }
      // Earlier builds used versions 1 and 2. Keep existing rows and extra
      // columns, adding only tables and optional/defaulted columns we require.
      await transaction(() async {
        final existing = await customSelect(
          "SELECT name FROM sqlite_master WHERE type IN ('table', 'index')",
        ).get();
        final names = existing.map((row) => row.read<String>('name')).toSet();
        for (final table in allTables) {
          if (!names.contains(table.actualTableName)) {
            await migrator.createTable(table);
            continue;
          }
          final columns = await customSelect(
            'PRAGMA table_info("${table.actualTableName}")',
          ).get();
          final columnNames = columns
              .map((row) => row.read<String>('name'))
              .toSet();
          for (final column in table.$columns) {
            if (columnNames.contains(column.$name)) continue;
            if ((!column.$nullable && column.defaultValue == null) ||
                column.defaultValue?.isLiteral == false) {
              throw StateError(
                'The saved library needs a compatible database update '
                '(${table.actualTableName}.${column.$name}). '
                'Your saved data has not been reset.',
              );
            }
            await migrator.addColumn(table, column);
          }
        }
        for (final index in allSchemaEntities.whereType<Index>()) {
          if (!names.contains(index.entityName)) {
            await migrator.createIndex(index);
          }
        }
        final violations = await customSelect('PRAGMA foreign_key_check').get();
        if (violations.isNotEmpty) {
          throw StateError(
            'The saved library needs repair. No data was removed.',
          );
        }
      });
    },
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON;');
    },
  );
}
