import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

const smartMemoryDatabaseFileName = 'smart_memory.sqlite';

Future<void> deleteSmartMemoryMigrationBackup() async {
  final supportDirectory = await getApplicationSupportDirectory();
  for (final version in [3, 4]) {
    final backup = File(
      p.join(
        supportDirectory.path,
        'smart_memory',
        '$smartMemoryDatabaseFileName.before-v$version.sqlite',
      ),
    );
    if (await backup.exists()) await backup.delete();
  }
}

QueryExecutor openSmartMemoryDatabase() {
  return LazyDatabase(() async {
    final supportDirectory = await getApplicationSupportDirectory();
    final databaseDirectory = Directory(
      p.join(supportDirectory.path, 'smart_memory'),
    );
    await databaseDirectory.create(recursive: true);

    final databaseFile = File(
      p.join(databaseDirectory.path, smartMemoryDatabaseFileName),
    );

    return NativeDatabase.createInBackground(
      databaseFile,
      setup: (database) {
        final version =
            database.select('PRAGMA user_version').first['user_version'] as int;
        if (version >= 1 && version <= 3) {
          final backup = File('${databaseFile.path}.before-v4.sqlite');
          if (!backup.existsSync()) {
            // Includes committed WAL data in a consistent snapshot.
            final path = backup.path.replaceAll("'", "''");
            database.execute("VACUUM INTO '$path'");
          }
        }
        database.execute('PRAGMA journal_mode = WAL;');
        database.execute('PRAGMA busy_timeout = 5000;');
      },
    );
  });
}
