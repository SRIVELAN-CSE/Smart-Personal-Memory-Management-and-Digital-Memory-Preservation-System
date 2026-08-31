import 'package:drift/drift.dart';

import 'database_connection.dart';
import 'tables.dart';

part 'app_database.g.dart';

const smartMemorySchemaVersion = 1;

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
  AppDatabase.production() : super(openSmartMemoryDatabase());

  AppDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => smartMemorySchemaVersion;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (migrator) async {
      // Version 1 is the initial schema. TableIndex annotations are emitted by
      // Drift as part of createAll, alongside every table and foreign key.
      await migrator.createAll();
    },
    onUpgrade: (migrator, from, to) async {
      throw StateError(
        'No Smart Memory migration exists from schema $from to $to.',
      );
    },
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON;');
    },
  );
}
