import 'package:banxin_calendar/features/backup/domain/backup_entities.dart';

abstract interface class BackupRepository {
  Future<LocalBackupEntry> createBackup({required String reason});

  Future<List<LocalBackupEntry>> listBackups();

  Future<BackupBundle> inspectBackup(String filePath);

  Future<void> restoreBackup(String filePath);

  Future<bool> isAutomaticBackupEnabled();

  Future<void> setAutomaticBackupEnabled(bool enabled);

  Future<void> pruneBackups({int keep = 7});
}

abstract interface class PrivacyDataStore {
  Future<void> clearConversations();

  Future<void> clearAssistantActions();

  Future<List<String>> loadCredentialReferences();

  Future<void> clearAssistantConfiguration();

  Future<void> clearWorkforceData();

  Future<void> clearAllData();
}
