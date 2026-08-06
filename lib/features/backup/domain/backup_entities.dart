import 'dart:convert';

final class BackupManifest {
  const BackupManifest({
    required this.backupId,
    required this.schemaVersion,
    required this.appVersion,
    required this.createdAtUtc,
    required this.dataRangeStart,
    required this.dataRangeEnd,
    required this.databaseChecksumSha256,
    required this.databaseByteLength,
    required this.secureCredentialsExcluded,
    required this.reason,
  });

  final String backupId;
  final int schemaVersion;
  final String appVersion;
  final DateTime createdAtUtc;
  final String? dataRangeStart;
  final String? dataRangeEnd;
  final String databaseChecksumSha256;
  final int databaseByteLength;
  final bool secureCredentialsExcluded;
  final String reason;

  Map<String, Object?> toJson() => <String, Object?>{
    'backup_id': backupId,
    'schema_version': schemaVersion,
    'app_version': appVersion,
    'created_at_utc': createdAtUtc.toIso8601String(),
    'data_range_start': dataRangeStart,
    'data_range_end': dataRangeEnd,
    'database_checksum_sha256': databaseChecksumSha256,
    'database_byte_length': databaseByteLength,
    'secure_credentials_excluded': secureCredentialsExcluded,
    'reason': reason,
  };

  factory BackupManifest.fromJson(Map<String, Object?> json) {
    T require<T>(String key) {
      final value = json[key];
      if (value is! T) {
        throw FormatException('Invalid backup manifest field: $key');
      }
      return value;
    }

    final createdAt = DateTime.tryParse(require<String>('created_at_utc'));
    if (createdAt == null) {
      throw const FormatException('Invalid backup creation time.');
    }
    return BackupManifest(
      backupId: require<String>('backup_id'),
      schemaVersion: require<int>('schema_version'),
      appVersion: require<String>('app_version'),
      createdAtUtc: createdAt.toUtc(),
      dataRangeStart: json['data_range_start'] as String?,
      dataRangeEnd: json['data_range_end'] as String?,
      databaseChecksumSha256: require<String>('database_checksum_sha256'),
      databaseByteLength: require<int>('database_byte_length'),
      secureCredentialsExcluded: require<bool>('secure_credentials_excluded'),
      reason: require<String>('reason'),
    );
  }
}

final class LocalBackupEntry {
  const LocalBackupEntry({required this.filePath, required this.manifest});

  final String filePath;
  final BackupManifest manifest;
}

final class BackupBundle {
  const BackupBundle({required this.manifest, required this.databaseBytes});

  static const int formatVersion = 1;

  final BackupManifest manifest;
  final List<int> databaseBytes;

  String encode() => jsonEncode(<String, Object?>{
    'format_version': formatVersion,
    'manifest': manifest.toJson(),
    'database_base64': base64Encode(databaseBytes),
  });

  factory BackupBundle.decode(String source) {
    final decoded = jsonDecode(source);
    if (decoded is! Map<String, dynamic> ||
        decoded['format_version'] != formatVersion ||
        decoded['manifest'] is! Map<String, dynamic> ||
        decoded['database_base64'] is! String) {
      throw const FormatException('Unsupported backup file.');
    }
    final bytes = base64Decode(decoded['database_base64'] as String);
    return BackupBundle(
      manifest: BackupManifest.fromJson(
        (decoded['manifest'] as Map<String, dynamic>).cast<String, Object?>(),
      ),
      databaseBytes: bytes,
    );
  }
}

final class BackupRestoreResult {
  const BackupRestoreResult({
    required this.preRestoreBackup,
    required this.alarmRebuildSucceeded,
  });

  final LocalBackupEntry preRestoreBackup;
  final bool alarmRebuildSucceeded;
}
