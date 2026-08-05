import 'dart:io';

import 'package:banxin_calendar/core/database/migrations/schema_versions.dart';
import 'package:banxin_calendar/core/database/tables/database_metadata.dart';
import 'package:banxin_calendar/core/database/tables/user_settings.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: <Type>[DatabaseMetadata, UserSettings])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  AppDatabase.inMemory() : super(NativeDatabase.memory());

  @override
  int get schemaVersion => SchemaVersions.current;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (migrator) async {
      await migrator.createAll();
    },
    onUpgrade: _upgrade,
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
      await customStatement('PRAGMA journal_mode = WAL');
    },
  );

  Future<void> ensureReady() async {
    await customSelect('SELECT 1').getSingle();
  }

  Future<void> _upgrade(Migrator migrator, int from, int to) async {
    if (from == SchemaVersions.metadataFoundation &&
        to == SchemaVersions.userSettings) {
      await migrator.createTable(userSettings);
      return;
    }

    throw UnsupportedError('Unsupported database migration: v$from to v$to');
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final databaseFile = File(
      path.join(documentsDirectory.path, 'banxin_calendar.sqlite'),
    );
    return NativeDatabase.createInBackground(databaseFile);
  });
}
