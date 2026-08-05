import 'dart:io';

import 'package:banxin_calendar/core/database/app_database.dart';
import 'package:banxin_calendar/core/database/migrations/schema_versions.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as path;
import 'package:sqlite3/sqlite3.dart' as sqlite;

void main() {
  group('AppDatabase migrations', () {
    late Directory tempDirectory;

    setUp(() async {
      tempDirectory = await Directory.systemTemp.createTemp(
        'banxin_calendar_db_test_',
      );
    });

    tearDown(() async {
      if (tempDirectory.existsSync()) {
        await tempDirectory.delete(recursive: true);
      }
    });

    test('creates a fresh database at the current schema', () async {
      final file = File(path.join(tempDirectory.path, 'fresh.sqlite'));
      final database = AppDatabase(NativeDatabase(file));
      addTearDown(database.close);

      await database.ensureReady();

      final version = await database
          .customSelect('PRAGMA user_version')
          .getSingle();
      final tables = await database
          .customSelect(
            "SELECT name FROM sqlite_master WHERE type = 'table' ORDER BY name",
          )
          .get();

      expect(version.data.values.single, SchemaVersions.current);
      expect(
        tables.map((row) => row.read<String>('name')),
        containsAll(<String>['database_metadata', 'user_settings']),
      );
    });

    test('migrates v1 to v2 without losing metadata', () async {
      final file = File(path.join(tempDirectory.path, 'legacy_v1.sqlite'));
      final legacy = sqlite.sqlite3.open(file.path);
      legacy.execute('''
        CREATE TABLE database_metadata (
          key TEXT NOT NULL PRIMARY KEY,
          value TEXT NOT NULL,
          created_at INTEGER NOT NULL,
          updated_at INTEGER NOT NULL
        );
        INSERT INTO database_metadata
          (key, value, created_at, updated_at)
        VALUES ('fixture', 'preserved', 1, 1);
        PRAGMA user_version = 1;
      ''');
      legacy.close();

      final database = AppDatabase(NativeDatabase(file));
      addTearDown(database.close);
      await database.ensureReady();

      final metadata = await database
          .select(database.databaseMetadata)
          .getSingle();
      final settings = await database.select(database.userSettings).get();

      expect(metadata.key, 'fixture');
      expect(metadata.value, 'preserved');
      expect(settings, isEmpty);
    });

    test('enables foreign keys and WAL for file databases', () async {
      final file = File(path.join(tempDirectory.path, 'pragmas.sqlite'));
      final database = AppDatabase(NativeDatabase(file));
      addTearDown(database.close);
      await database.ensureReady();

      final foreignKeys = await database
          .customSelect('PRAGMA foreign_keys')
          .getSingle();
      final journalMode = await database
          .customSelect('PRAGMA journal_mode')
          .getSingle();

      expect(foreignKeys.data.values.single, 1);
      expect(journalMode.data.values.single.toString().toLowerCase(), 'wal');
    });

    test('does not create secret-bearing database columns', () async {
      final database = AppDatabase.inMemory();
      addTearDown(database.close);
      await database.ensureReady();

      final schemaRows = await database
          .customSelect(
            "SELECT sql FROM sqlite_master WHERE type = 'table' AND sql IS NOT NULL",
          )
          .get();
      final schema = schemaRows
          .map((row) => row.read<String>('sql'))
          .join('\n')
          .toLowerCase();

      expect(schema, isNot(contains('api_key')));
      expect(schema, isNot(contains('authorization')));
      expect(schema, isNot(contains('custom_headers')));
    });
  });
}
