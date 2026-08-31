import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

const smartMemoryDatabaseFileName = 'smart_memory.sqlite';

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
        database.execute('PRAGMA journal_mode = WAL;');
        database.execute('PRAGMA busy_timeout = 5000;');
      },
    );
  });
}
