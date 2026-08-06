import 'dart:io';

import 'package:banxin_calendar/core/app_version.dart';
import 'package:banxin_calendar/core/database/app_database.dart';
import 'package:banxin_calendar/core/database/migrations/schema_versions.dart';
import 'package:banxin_calendar/core/ids/stable_id_generator.dart';
import 'package:banxin_calendar/core/time/app_clock.dart';
import 'package:banxin_calendar/features/backup/domain/backup_entities.dart';
import 'package:banxin_calendar/features/backup/domain/backup_repository.dart';
import 'package:crypto/crypto.dart';
import 'package:drift/drift.dart' show driftRuntimeOptions;
import 'package:drift/native.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart' as sqlite;

typedef BackupDirectoryResolver = Future<Directory> Function();

final class LocalBackupRepository implements BackupRepository {
  LocalBackupRepository(
    this._database, {
    BackupDirectoryResolver? directoryResolver,
    StableIdGenerator? idGenerator,
    this._clock = const SystemAppClock(),
  }) : _directoryResolver = directoryResolver ?? _defaultDirectory,
       _idGenerator = idGenerator ?? UuidV4Generator();

  static const String _extension = '.banxinbackup';
  static const String _autoBackupKey = 'automatic_backup_enabled';
  static const int _maximumBundleBytes = 700 * 1024 * 1024;

  final AppDatabase _database;
  final BackupDirectoryResolver _directoryResolver;
  final StableIdGenerator _idGenerator;
  final AppClock _clock;

  @override
  Future<LocalBackupEntry> createBackup({required String reason}) async {
    await _database.ensureReady();
    final directory = await _safeDirectory();
    final backupId = _idGenerator.generate();
    final snapshotFile = File(path.join(directory.path, '.$backupId.sqlite'));
    final outputFile = File(
      path.join(
        directory.path,
        'banxin-${_fileTimestamp()}-$backupId$_extension',
      ),
    );
    final outputTemp = File('${outputFile.path}.tmp');
    _assertInside(directory, snapshotFile.path);
    _assertInside(directory, outputFile.path);
    _assertInside(directory, outputTemp.path);

    try {
      await _database.customStatement(
        "VACUUM INTO '${_sqlString(snapshotFile.path)}'",
      );
      _redactCredentials(snapshotFile);
      final bytes = await snapshotFile.readAsBytes();
      final range = await _loadDataRange();
      final manifest = BackupManifest(
        backupId: backupId,
        schemaVersion: SchemaVersions.current,
        appVersion: AppVersion.display,
        createdAtUtc: _clock.nowUtc(),
        dataRangeStart: range.$1,
        dataRangeEnd: range.$2,
        databaseChecksumSha256: sha256.convert(bytes).toString(),
        databaseByteLength: bytes.length,
        secureCredentialsExcluded: true,
        reason: reason,
      );
      final bundle = BackupBundle(manifest: manifest, databaseBytes: bytes);
      await outputTemp.writeAsString(bundle.encode(), flush: true);
      await outputTemp.rename(outputFile.path);
      return LocalBackupEntry(filePath: outputFile.path, manifest: manifest);
    } finally {
      await _deleteIfExists(snapshotFile, directory);
      await _deleteIfExists(File('${snapshotFile.path}-wal'), directory);
      await _deleteIfExists(File('${snapshotFile.path}-shm'), directory);
      await _deleteIfExists(outputTemp, directory);
    }
  }

  @override
  Future<List<LocalBackupEntry>> listBackups() async {
    final directory = await _safeDirectory();
    final entries = <LocalBackupEntry>[];
    await for (final entity in directory.list()) {
      if (entity is! File || !entity.path.endsWith(_extension)) {
        continue;
      }
      final bundle = await inspectBackup(entity.path);
      entries.add(
        LocalBackupEntry(filePath: entity.path, manifest: bundle.manifest),
      );
    }
    entries.sort(
      (left, right) =>
          right.manifest.createdAtUtc.compareTo(left.manifest.createdAtUtc),
    );
    return List<LocalBackupEntry>.unmodifiable(entries);
  }

  @override
  Future<BackupBundle> inspectBackup(String filePath) async {
    final file = File(filePath);
    if (!await file.exists()) {
      throw const FormatException('Backup file does not exist.');
    }
    final length = await file.length();
    if (length <= 0 || length > _maximumBundleBytes) {
      throw const FormatException('Backup file size is invalid.');
    }
    final bundle = BackupBundle.decode(await file.readAsString());
    _validateBundle(bundle);
    return bundle;
  }

  @override
  Future<void> restoreBackup(String filePath) async {
    final bundle = await inspectBackup(filePath);
    final directory = await _safeDirectory();
    final restoreFile = File(
      path.join(directory.path, '.restore-${bundle.manifest.backupId}.sqlite'),
    );
    _assertInside(directory, restoreFile.path);
    try {
      await restoreFile.writeAsBytes(bundle.databaseBytes, flush: true);
      await _validateAndMigrateTemporaryDatabase(restoreFile);
      await _replaceDatabaseAtomically(restoreFile);
    } finally {
      await _deleteIfExists(restoreFile, directory);
      await _deleteIfExists(File('${restoreFile.path}-wal'), directory);
      await _deleteIfExists(File('${restoreFile.path}-shm'), directory);
    }
  }

  @override
  Future<bool> isAutomaticBackupEnabled() async {
    final row = await (_database.select(
      _database.databaseMetadata,
    )..where((table) => table.key.equals(_autoBackupKey))).getSingleOrNull();
    return row?.value != 'false';
  }

  @override
  Future<void> setAutomaticBackupEnabled(bool enabled) async {
    final now = _clock.nowUtc().millisecondsSinceEpoch;
    await _database.customStatement(
      '''
      INSERT INTO database_metadata (key, value, created_at, updated_at)
      VALUES (?, ?, ?, ?)
      ON CONFLICT(key) DO UPDATE SET value = excluded.value,
        updated_at = excluded.updated_at
      ''',
      <Object>[_autoBackupKey, enabled.toString(), now, now],
    );
  }

  @override
  Future<void> pruneBackups({int keep = 7}) async {
    if (keep < 7) {
      throw ArgumentError.value(keep, 'keep', 'Must keep at least 7 backups.');
    }
    final directory = await _safeDirectory();
    final entries = await listBackups();
    for (final entry in entries.skip(keep)) {
      await _deleteIfExists(File(entry.filePath), directory);
    }
  }

  void _redactCredentials(File snapshotFile) {
    final snapshot = sqlite.sqlite3.open(snapshotFile.path);
    try {
      snapshot.execute('PRAGMA secure_delete = ON');
      snapshot.execute('''
        UPDATE ai_provider_configs
        SET credential_ref = 'backup-excluded',
            custom_headers_ref = NULL,
            connection_status = 'notTested',
            last_tested_at = NULL
      ''');
      snapshot.execute('VACUUM');
      final integrity = snapshot.select('PRAGMA integrity_check');
      if (integrity.isEmpty || integrity.first.values.first != 'ok') {
        throw const FormatException('Snapshot integrity check failed.');
      }
    } finally {
      snapshot.close();
    }
  }

  Future<(String?, String?)> _loadDataRange() async {
    final row = await _database.customSelect('''
      SELECT MIN(date_value) AS min_date, MAX(date_value) AS max_date
      FROM (
        SELECT work_date AS date_value FROM day_overrides
        UNION ALL SELECT work_date FROM holiday_records
        UNION ALL SELECT schedule_date FROM alarm_instances
        UNION ALL SELECT work_date FROM attendance_records
        UNION ALL SELECT work_date FROM leave_records
        UNION ALL SELECT effective_start FROM schedule_rules
        UNION ALL SELECT effective_end FROM schedule_rules
        UNION ALL SELECT effective_start FROM wage_rules
        UNION ALL SELECT effective_end FROM wage_rules
        UNION ALL SELECT start_date FROM payroll_periods
        UNION ALL SELECT end_date FROM payroll_periods
      ) WHERE date_value IS NOT NULL
    ''').getSingle();
    return (
      row.readNullable<String>('min_date'),
      row.readNullable<String>('max_date'),
    );
  }

  void _validateBundle(BackupBundle bundle) {
    final manifest = bundle.manifest;
    if (manifest.schemaVersion < 1 ||
        manifest.schemaVersion > SchemaVersions.current) {
      throw const FormatException('Backup schema is not supported.');
    }
    if (!manifest.secureCredentialsExcluded) {
      throw const FormatException('Backup may contain secure credentials.');
    }
    if (bundle.databaseBytes.length != manifest.databaseByteLength ||
        sha256.convert(bundle.databaseBytes).toString() !=
            manifest.databaseChecksumSha256) {
      throw const FormatException('Backup checksum validation failed.');
    }
  }

  Future<void> _validateAndMigrateTemporaryDatabase(File file) async {
    final previousWarningSetting =
        driftRuntimeOptions.dontWarnAboutMultipleDatabases;
    driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
    late AppDatabase temporary;
    try {
      temporary = AppDatabase(NativeDatabase(file));
    } finally {
      driftRuntimeOptions.dontWarnAboutMultipleDatabases =
          previousWarningSetting;
    }
    try {
      await temporary.ensureReady();
      final integrity = await temporary
          .customSelect('PRAGMA integrity_check')
          .getSingle();
      final foreignKeyErrors = await temporary
          .customSelect('PRAGMA foreign_key_check')
          .get();
      final version = await temporary
          .customSelect('PRAGMA user_version')
          .getSingle();
      if (integrity.data.values.single != 'ok' ||
          foreignKeyErrors.isNotEmpty ||
          version.data.values.single != SchemaVersions.current) {
        throw const FormatException('Backup database validation failed.');
      }
    } finally {
      await temporary.close();
    }
  }

  Future<void> _replaceDatabaseAtomically(File restoreFile) async {
    const deleteOrder = <String>[
      'messages',
      'ai_actions',
      'conversations',
      'shift_alarm_templates',
      'alarm_instances',
      'alarm_templates',
      'day_overrides',
      'calendar_day_cache',
      'schedule_rules',
      'holiday_records',
      'attendance_records',
      'leave_records',
      'payroll_periods',
      'wage_rules',
      'assistant_personas',
      'ai_provider_configs',
      'change_log',
      'shift_templates',
      'user_settings',
      'database_metadata',
    ];
    const insertOrder = <String>[
      'database_metadata',
      'user_settings',
      'shift_templates',
      'schedule_rules',
      'day_overrides',
      'holiday_records',
      'change_log',
      'alarm_templates',
      'shift_alarm_templates',
      'attendance_records',
      'leave_records',
      'wage_rules',
      'payroll_periods',
      'ai_provider_configs',
      'assistant_personas',
      'conversations',
      'messages',
      'ai_actions',
    ];

    await _database.customStatement(
      "ATTACH DATABASE '${_sqlString(restoreFile.path)}' AS restore_db",
    );
    try {
      await _database.transaction(() async {
        for (final table in deleteOrder) {
          await _database.customStatement('DELETE FROM main.$table');
        }
        for (final table in insertOrder) {
          await _database.customStatement(
            'INSERT INTO main.$table SELECT * FROM restore_db.$table',
          );
        }
        final foreignKeyErrors = await _database
            .customSelect('PRAGMA main.foreign_key_check')
            .get();
        if (foreignKeyErrors.isNotEmpty) {
          throw const FormatException('Restored data has broken references.');
        }
      });
    } finally {
      await _database.customStatement('DETACH DATABASE restore_db');
    }
  }

  Future<Directory> _safeDirectory() async {
    final directory = await _directoryResolver();
    await directory.create(recursive: true);
    return Directory(path.normalize(directory.absolute.path));
  }

  void _assertInside(Directory directory, String candidate) {
    final root = path.normalize(directory.absolute.path);
    final target = path.normalize(File(candidate).absolute.path);
    if (!path.isWithin(root, target)) {
      throw StateError('Backup path escaped its managed directory.');
    }
  }

  Future<void> _deleteIfExists(File file, Directory directory) async {
    _assertInside(directory, file.path);
    if (await file.exists()) {
      await file.delete();
    }
  }

  String _fileTimestamp() => _clock
      .nowUtc()
      .toIso8601String()
      .replaceAll(':', '')
      .replaceAll('.', '-');

  static String _sqlString(String value) => value.replaceAll("'", "''");

  static Future<Directory> _defaultDirectory() async {
    final documents = await getApplicationDocumentsDirectory();
    return Directory(path.join(documents.path, 'backups'));
  }
}
