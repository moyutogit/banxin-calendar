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
        containsAll(<String>[
          'calendar_day_cache',
          'change_log',
          'database_metadata',
          'day_overrides',
          'holiday_records',
          'schedule_rules',
          'shift_templates',
          'user_settings',
          'alarm_templates',
          'shift_alarm_templates',
          'alarm_instances',
          'attendance_records',
          'leave_records',
          'wage_rules',
          'payroll_periods',
          'ai_provider_configs',
          'assistant_personas',
          'conversations',
          'messages',
          'ai_actions',
        ]),
      );
    });

    test('migrates v1 to current without losing metadata', () async {
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

    test('migrates v2 to current without losing user settings', () async {
      final file = File(path.join(tempDirectory.path, 'legacy_v2.sqlite'));
      final legacy = sqlite.sqlite3.open(file.path);
      legacy.execute('''
        CREATE TABLE database_metadata (
          key TEXT NOT NULL PRIMARY KEY,
          value TEXT NOT NULL,
          created_at INTEGER NOT NULL,
          updated_at INTEGER NOT NULL
        );
        CREATE TABLE user_settings (
          id TEXT NOT NULL PRIMARY KEY,
          locale TEXT NOT NULL,
          timezone TEXT NOT NULL,
          currency TEXT NOT NULL,
          week_start INTEGER NOT NULL,
          hour_display_mode TEXT NOT NULL,
          theme_mode TEXT NOT NULL,
          holiday_region TEXT NOT NULL,
          created_at INTEGER NOT NULL,
          updated_at INTEGER NOT NULL
        );
        INSERT INTO user_settings (
          id,
          locale,
          timezone,
          currency,
          week_start,
          hour_display_mode,
          theme_mode,
          holiday_region,
          created_at,
          updated_at
        ) VALUES (
          'local',
          'zh_CN',
          'Asia/Shanghai',
          'CNY',
          1,
          '24h',
          'system',
          'CN',
          1,
          1
        );
        PRAGMA user_version = 2;
      ''');
      legacy.close();

      final database = AppDatabase(NativeDatabase(file));
      addTearDown(database.close);
      await database.ensureReady();

      final settings = await database.select(database.userSettings).getSingle();
      final tables = await database
          .customSelect(
            "SELECT name FROM sqlite_master WHERE type = 'table' ORDER BY name",
          )
          .get();

      expect(settings.id, 'local');
      expect(settings.locale, 'zh_CN');
      expect(
        tables.map((row) => row.read<String>('name')),
        containsAll(<String>[
          'calendar_day_cache',
          'change_log',
          'day_overrides',
          'holiday_records',
          'schedule_rules',
          'shift_templates',
        ]),
      );
    });

    test(
      'migrates v3 to alarm schema without losing schedule metadata',
      () async {
        final file = File(path.join(tempDirectory.path, 'legacy_v3.sqlite'));
        final legacy = sqlite.sqlite3.open(file.path);
        legacy.execute('''
        CREATE TABLE database_metadata (
          key TEXT NOT NULL PRIMARY KEY,
          value TEXT NOT NULL,
          created_at INTEGER NOT NULL,
          updated_at INTEGER NOT NULL
        );
        CREATE TABLE shift_templates (
          id TEXT NOT NULL PRIMARY KEY,
          name TEXT NOT NULL,
          short_name TEXT NOT NULL,
          start_minute INTEGER,
          end_minute INTEGER,
          cross_day INTEGER NOT NULL,
          unpaid_break_minutes INTEGER NOT NULL,
          planned_paid_minutes INTEGER,
          color_argb INTEGER NOT NULL,
          is_workday INTEGER NOT NULL,
          enabled INTEGER NOT NULL,
          created_at INTEGER NOT NULL,
          updated_at INTEGER NOT NULL,
          deleted_at INTEGER
        );
        INSERT INTO database_metadata
          (key, value, created_at, updated_at)
        VALUES ('schedule_input_version', '17', 1, 1);
        INSERT INTO shift_templates VALUES (
          'preserved-shift', 'Day', 'D', 540, 1080, 0, 60, 480,
          4282090230, 1, 1, 1, 1, NULL
        );
        PRAGMA user_version = 3;
      ''');
        legacy.close();

        final database = AppDatabase(NativeDatabase(file));
        addTearDown(database.close);
        await database.ensureReady();

        final metadata = await database
            .select(database.databaseMetadata)
            .getSingle();
        final shift = await database
            .select(database.shiftTemplates)
            .getSingle();
        final tables = await database
            .customSelect(
              "SELECT name FROM sqlite_master WHERE type = 'table' ORDER BY name",
            )
            .get();

        expect(metadata.value, '17');
        expect(shift.id, 'preserved-shift');
        expect(
          tables.map((row) => row.read<String>('name')),
          containsAll(<String>[
            'alarm_templates',
            'shift_alarm_templates',
            'alarm_instances',
          ]),
        );
      },
    );

    test('migrates v4 to workforce schema without losing metadata', () async {
      final file = File(path.join(tempDirectory.path, 'legacy_v4.sqlite'));
      final legacy = sqlite.sqlite3.open(file.path);
      legacy.execute('''
        CREATE TABLE database_metadata (
          key TEXT NOT NULL PRIMARY KEY,
          value TEXT NOT NULL,
          created_at INTEGER NOT NULL,
          updated_at INTEGER NOT NULL
        );
        INSERT INTO database_metadata VALUES ('fixture', 'v4', 1, 1);
        PRAGMA user_version = 4;
      ''');
      legacy.close();

      final database = AppDatabase(NativeDatabase(file));
      addTearDown(database.close);
      await database.ensureReady();

      final metadata = await database
          .select(database.databaseMetadata)
          .getSingle();
      final tables = await database
          .customSelect(
            "SELECT name FROM sqlite_master WHERE type = 'table' ORDER BY name",
          )
          .get();
      expect(metadata.value, 'v4');
      expect(
        tables.map((row) => row.read<String>('name')),
        containsAll(<String>[
          'attendance_records',
          'leave_records',
          'wage_rules',
          'payroll_periods',
        ]),
      );
    });

    test('migrates v5 to assistant schema without exposing secrets', () async {
      final file = File(path.join(tempDirectory.path, 'legacy_v5.sqlite'));
      final legacy = sqlite.sqlite3.open(file.path);
      legacy.execute('''
        CREATE TABLE database_metadata (
          key TEXT NOT NULL PRIMARY KEY,
          value TEXT NOT NULL,
          created_at INTEGER NOT NULL,
          updated_at INTEGER NOT NULL
        );
        INSERT INTO database_metadata VALUES ('fixture', 'v5', 1, 1);
        PRAGMA user_version = 5;
      ''');
      legacy.close();

      final database = AppDatabase(NativeDatabase(file));
      addTearDown(database.close);
      await database.ensureReady();
      final metadata = await database
          .select(database.databaseMetadata)
          .getSingle();
      final schema = await database
          .customSelect(
            "SELECT sql FROM sqlite_master WHERE type = 'table' AND sql IS NOT NULL",
          )
          .get();
      final schemaText = schema
          .map((row) => row.read<String>('sql'))
          .join('\n')
          .toLowerCase();

      expect(metadata.value, 'v5');
      expect(schemaText, contains('ai_provider_configs'));
      expect(schemaText, contains('credential_ref'));
      expect(schemaText, isNot(contains('api_key')));
      expect(schemaText, isNot(contains('authorization_header')));
    });

    test(
      'migrates v6 messages to persisted reasoning without data loss',
      () async {
        final file = File(path.join(tempDirectory.path, 'legacy_v6.sqlite'));
        final legacy = sqlite.sqlite3.open(file.path);
        legacy.execute('''
        CREATE TABLE conversations (
          id TEXT NOT NULL PRIMARY KEY,
          title TEXT NOT NULL,
          model_snapshot_json TEXT NOT NULL,
          created_at INTEGER NOT NULL,
          updated_at INTEGER NOT NULL,
          archived_at INTEGER
        );
        CREATE TABLE messages (
          id TEXT NOT NULL PRIMARY KEY,
          conversation_id TEXT NOT NULL REFERENCES conversations(id),
          role TEXT NOT NULL,
          content TEXT NOT NULL,
          content_type TEXT NOT NULL,
          tool_call_id TEXT,
          local_only INTEGER NOT NULL,
          created_at INTEGER NOT NULL
        );
        INSERT INTO conversations VALUES (
          'conversation', '保留的会话', '{}', 1, 1, NULL
        );
        INSERT INTO messages VALUES (
          'message', 'conversation', 'assistant', '保留的回复',
          'text', NULL, 0, 1
        );
        PRAGMA user_version = 6;
      ''');
        legacy.close();

        final database = AppDatabase(NativeDatabase(file));
        addTearDown(database.close);
        await database.ensureReady();

        final message = await database.select(database.messages).getSingle();
        final version = await database
            .customSelect('PRAGMA user_version')
            .getSingle();

        expect(version.data.values.single, SchemaVersions.current);
        expect(message.content, '保留的回复');
        expect(message.reasoningContent, isNull);
      },
    );

    test('migrates v7 persona to local agent memory schema', () async {
      final file = File(path.join(tempDirectory.path, 'legacy_v7.sqlite'));
      final legacy = sqlite.sqlite3.open(file.path);
      legacy.execute('''
        CREATE TABLE assistant_personas (
          id TEXT NOT NULL PRIMARY KEY,
          display_name TEXT NOT NULL,
          preset_type TEXT NOT NULL,
          custom_instruction TEXT,
          reply_length TEXT NOT NULL,
          initiative_level INTEGER NOT NULL,
          emoji_level INTEGER NOT NULL,
          avatar_asset_id TEXT NOT NULL,
          schedule_read INTEGER NOT NULL,
          attendance_read INTEGER NOT NULL,
          wage_read INTEGER NOT NULL,
          alarm_read INTEGER NOT NULL,
          notes_read INTEGER NOT NULL,
          updated_at INTEGER NOT NULL
        );
        INSERT INTO assistant_personas VALUES (
          'persona', '小班', 'gentle', NULL, 'medium', 1, 1,
          'default_gentle', 1, 1, 0, 1, 0, 1
        );
        PRAGMA user_version = 7;
      ''');
      legacy.close();

      final database = AppDatabase(NativeDatabase(file));
      addTearDown(database.close);
      await database.ensureReady();
      final persona = await database
          .select(database.assistantPersonas)
          .getSingle();
      final memoryTable = await database
          .customSelect(
            "SELECT name FROM sqlite_master WHERE type = 'table' AND name = 'assistant_memories'",
          )
          .getSingleOrNull();

      expect(persona.displayName, '小班');
      expect(persona.memoryRead, 1);
      expect(memoryTable, isNotNull);
    });

    test('allows only one active override per date', () async {
      final database = AppDatabase.inMemory();
      addTearDown(database.close);
      await database.ensureReady();

      Future<void> insertOverride(String id) => database.customStatement(
        '''
        INSERT INTO day_overrides (
          id,
          work_date,
          status,
          shift_template_id,
          shift_snapshot_json,
          override_type,
          reason,
          note,
          created_at,
          updated_at,
          deleted_at
        ) VALUES (?, '2026-08-15', 'rest', NULL, NULL, 'user', NULL, NULL, 1, 1, NULL)
        ''',
        <Object>[id],
      );

      await insertOverride('first');

      await expectLater(
        insertOverride('second'),
        throwsA(isA<sqlite.SqliteException>()),
      );

      await database.customStatement(
        'UPDATE day_overrides SET deleted_at = 2 WHERE id = ?',
        <Object>['first'],
      );
      await insertOverride('second');

      final activeCount = await database
          .customSelect(
            'SELECT COUNT(*) AS count FROM day_overrides WHERE deleted_at IS NULL',
          )
          .getSingle();
      expect(activeCount.read<int>('count'), 1);
    });

    test('enforces override shift-template foreign keys', () async {
      final database = AppDatabase.inMemory();
      addTearDown(database.close);
      await database.ensureReady();

      await expectLater(
        database.customStatement('''
          INSERT INTO day_overrides (
            id,
            work_date,
            status,
            shift_template_id,
            shift_snapshot_json,
            override_type,
            reason,
            note,
            created_at,
            updated_at,
            deleted_at
          ) VALUES (
            'invalid-shift',
            '2026-08-16',
            'work',
            'missing',
            NULL,
            'user',
            NULL,
            NULL,
            1,
            1,
            NULL
          )
        '''),
        throwsA(isA<sqlite.SqliteException>()),
      );
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
      expect(schema, isNot(matches(RegExp(r'custom_headers(?!_ref)'))));
    });
  });
}
