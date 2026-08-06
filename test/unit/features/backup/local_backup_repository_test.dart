import 'dart:convert';
import 'dart:io';

import 'package:banxin_calendar/core/database/app_database.dart';
import 'package:banxin_calendar/core/ids/stable_id_generator.dart';
import 'package:banxin_calendar/core/time/app_clock.dart';
import 'package:banxin_calendar/features/backup/data/drift_privacy_data_store.dart';
import 'package:banxin_calendar/features/backup/data/local_backup_repository.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as path;

void main() {
  group('LocalBackupRepository', () {
    late Directory temporaryDirectory;
    late Directory backupDirectory;
    late AppDatabase database;
    late LocalBackupRepository repository;

    setUp(() async {
      temporaryDirectory = await Directory.systemTemp.createTemp(
        'banxin_backup_test_',
      );
      backupDirectory = Directory(
        path.join(temporaryDirectory.path, 'managed-backups'),
      );
      database = AppDatabase(
        NativeDatabase(File(path.join(temporaryDirectory.path, 'live.sqlite'))),
      );
      await database.ensureReady();
      repository = LocalBackupRepository(
        database,
        directoryResolver: () async => backupDirectory,
        idGenerator: _SequenceIdGenerator(),
        clock: _FixedClock(DateTime.utc(2026, 8, 6, 3, 4, 5)),
      );
    });

    tearDown(() async {
      await database.close();
      if (temporaryDirectory.existsSync()) {
        await temporaryDirectory.delete(recursive: true);
      }
    });

    test(
      'creates a consistent verified snapshot without credential references',
      () async {
        await _putMetadata(database, 'fixture', 'original');
        await database.customStatement('''
          INSERT INTO ai_provider_configs (
            id, provider_type, base_url, endpoint_path, model_name,
            credential_ref, custom_headers_ref, timeout_seconds,
            max_output_tokens, stream_enabled, connection_status,
            last_tested_at, created_at, updated_at
          ) VALUES (
            'provider', 'openAiCompatible', 'https://example.com',
            '/v1/chat/completions', 'model', 'credential-secret-reference',
            'headers-secret-reference', 30, 1024, 1, 'connected', 1, 1, 1
          )
        ''');

        final entry = await repository.createBackup(reason: 'manual');
        final bundle = await repository.inspectBackup(entry.filePath);

        expect(bundle.manifest.schemaVersion, database.schemaVersion);
        expect(bundle.manifest.appVersion, '0.1.0+1');
        expect(bundle.manifest.secureCredentialsExcluded, isTrue);
        expect(bundle.manifest.databaseChecksumSha256, hasLength(64));
        final rawDatabase = latin1.decode(
          bundle.databaseBytes,
          allowInvalid: true,
        );
        expect(rawDatabase, isNot(contains('credential-secret-reference')));
        expect(rawDatabase, isNot(contains('headers-secret-reference')));
      },
    );

    test('restores atomically from a validated temporary database', () async {
      await _putMetadata(database, 'fixture', 'original');
      await database.customStatement('''
        INSERT INTO conversations VALUES (
          'conversation', '记忆来源', '{}', 1, 1, NULL
        )
      ''');
      await database.customStatement('''
        INSERT INTO assistant_memories VALUES (
          'memory', '用户不吃香菜', 'personalFact', 'conversation',
          1, 1, NULL
        )
      ''');
      final entry = await repository.createBackup(reason: 'manual');
      await _putMetadata(database, 'fixture', 'changed');
      await database.customStatement(
        "UPDATE assistant_memories SET content = '已被修改' WHERE id = 'memory'",
      );

      await repository.restoreBackup(entry.filePath);

      final restored = await (database.select(
        database.databaseMetadata,
      )..where((table) => table.key.equals('fixture'))).getSingle();
      expect(restored.value, 'original');
      expect(
        (await database.select(database.assistantMemories).getSingle()).content,
        '用户不吃香菜',
      );
      final integrity = await database
          .customSelect('PRAGMA integrity_check')
          .getSingle();
      expect(integrity.data.values.single, 'ok');
    });

    test('rejects a modified checksum without touching live data', () async {
      await _putMetadata(database, 'fixture', 'original');
      final entry = await repository.createBackup(reason: 'manual');
      final source =
          jsonDecode(await File(entry.filePath).readAsString())
              as Map<String, dynamic>;
      (source['manifest'] as Map<String, dynamic>)['database_checksum_sha256'] =
          List<String>.filled(64, '0').join();
      final corrupt = File(
        path.join(backupDirectory.path, 'corrupt.banxinbackup'),
      );
      await corrupt.writeAsString(jsonEncode(source));
      await _putMetadata(database, 'fixture', 'still-live');

      await expectLater(
        repository.restoreBackup(corrupt.path),
        throwsA(isA<FormatException>()),
      );
      final live = await (database.select(
        database.databaseMetadata,
      )..where((table) => table.key.equals('fixture'))).getSingle();
      expect(live.value, 'still-live');
    });

    test('retains no fewer than seven managed backups', () async {
      for (var index = 0; index < 9; index++) {
        await repository.createBackup(reason: 'manual');
      }

      await repository.pruneBackups();

      expect(await repository.listBackups(), hasLength(7));
      await expectLater(repository.pruneBackups(keep: 6), throwsArgumentError);
    });
  });

  group('DriftPrivacyDataStore', () {
    test(
      'clears conversations and locally saved agent memories together',
      () async {
        final database = AppDatabase.inMemory();
        addTearDown(database.close);
        await database.ensureReady();
        await database.customStatement('''
        INSERT INTO conversations VALUES (
          'conversation', '对话', '{}', 1, 1, NULL
        )
      ''');
        await database.customStatement('''
        INSERT INTO assistant_memories VALUES (
          'memory', '用户不吃香菜', 'personalFact', 'conversation',
          1, 1, NULL
        )
      ''');

        await DriftPrivacyDataStore(database).clearConversations();

        expect(await database.select(database.conversations).get(), isEmpty);
        expect(
          await database.select(database.assistantMemories).get(),
          isEmpty,
        );
      },
    );

    test('clears workforce independently from schedules', () async {
      final database = AppDatabase.inMemory();
      addTearDown(database.close);
      await database.ensureReady();
      await database.customStatement('''
        INSERT INTO shift_templates VALUES (
          'shift', 'Day', 'D', 540, 1080, 0, 60, 480,
          4282090230, 1, 1, 1, 1, NULL
        )
      ''');
      await database.customStatement('''
        INSERT INTO attendance_records VALUES (
          'attendance', '2026-08-06', 1, 2, 0, 'manual', 'complete',
          NULL, NULL, 'Asia/Shanghai', 1, 1, 1, NULL
        )
      ''');
      final store = DriftPrivacyDataStore(database);

      await store.clearWorkforceData();

      expect(await database.select(database.attendanceRecords).get(), isEmpty);
      expect(
        await database.select(database.shiftTemplates).get(),
        hasLength(1),
      );
    });
  });
}

Future<void> _putMetadata(AppDatabase database, String key, String value) {
  return database.customStatement(
    '''
    INSERT INTO database_metadata (key, value, created_at, updated_at)
    VALUES (?, ?, 1, 1)
    ON CONFLICT(key) DO UPDATE SET value = excluded.value
    ''',
    <Object>[key, value],
  );
}

final class _SequenceIdGenerator implements StableIdGenerator {
  var _next = 0;

  @override
  String generate() => 'backup-${_next++}';
}

final class _FixedClock implements AppClock {
  const _FixedClock(this.value);

  final DateTime value;

  @override
  DateTime nowUtc() => value;
}
