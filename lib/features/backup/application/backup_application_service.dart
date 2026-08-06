import 'package:banxin_calendar/core/secure_storage/secure_credential_service.dart';
import 'package:banxin_calendar/features/alarm/application/alarm_application_service.dart';
import 'package:banxin_calendar/features/backup/domain/backup_entities.dart';
import 'package:banxin_calendar/features/backup/domain/backup_repository.dart';

enum PrivacyClearTarget {
  conversations,
  assistantActions,
  assistantConfiguration,
  workforce,
  all,
}

final class BackupApplicationService {
  const BackupApplicationService(
    this._repository,
    this._privacyDataStore,
    this._secureCredentialService,
    this._alarmApplicationService,
  );

  final BackupRepository _repository;
  final PrivacyDataStore _privacyDataStore;
  final SecureCredentialService _secureCredentialService;
  final AlarmApplicationService _alarmApplicationService;

  Future<List<LocalBackupEntry>> loadBackups() {
    return _repository.listBackups();
  }

  Future<bool> isAutomaticBackupEnabled() {
    return _repository.isAutomaticBackupEnabled();
  }

  Future<void> setAutomaticBackupEnabled(bool enabled) {
    return _repository.setAutomaticBackupEnabled(enabled);
  }

  Future<LocalBackupEntry> createManualBackup() async {
    final result = await _repository.createBackup(reason: 'manual');
    await _repository.pruneBackups();
    return result;
  }

  Future<void> runAutomaticBackupIfNeeded({DateTime? nowUtc}) async {
    if (!await _repository.isAutomaticBackupEnabled()) {
      return;
    }
    final now = (nowUtc ?? DateTime.now().toUtc()).toUtc();
    final backups = await _repository.listBackups();
    final alreadyCreatedToday = backups.any((entry) {
      final created = entry.manifest.createdAtUtc;
      return entry.manifest.reason == 'automatic' &&
          created.year == now.year &&
          created.month == now.month &&
          created.day == now.day;
    });
    if (!alreadyCreatedToday) {
      await _repository.createBackup(reason: 'automatic');
      await _repository.pruneBackups();
    }
  }

  Future<BackupBundle> inspectBackup(LocalBackupEntry entry) {
    return _repository.inspectBackup(entry.filePath);
  }

  Future<BackupRestoreResult> restore(LocalBackupEntry entry) async {
    await _repository.inspectBackup(entry.filePath);
    final safetyBackup = await _repository.createBackup(reason: 'pre_restore');
    await _repository.restoreBackup(entry.filePath);
    var alarmRebuildSucceeded = false;
    try {
      final alarmResult = await _alarmApplicationService.syncRollingWindow();
      alarmRebuildSucceeded = alarmResult.failed == 0;
    } on Object {
      alarmRebuildSucceeded = false;
    }
    await _repository.pruneBackups();
    return BackupRestoreResult(
      preRestoreBackup: safetyBackup,
      alarmRebuildSucceeded: alarmRebuildSucceeded,
    );
  }

  Future<void> clear(PrivacyClearTarget target) async {
    if (target != PrivacyClearTarget.assistantConfiguration) {
      await _repository.createBackup(reason: 'pre_clear_${target.name}');
    }
    switch (target) {
      case PrivacyClearTarget.conversations:
        await _privacyDataStore.clearConversations();
      case PrivacyClearTarget.assistantActions:
        await _privacyDataStore.clearAssistantActions();
      case PrivacyClearTarget.assistantConfiguration:
        await _clearAssistantConfiguration();
      case PrivacyClearTarget.workforce:
        await _privacyDataStore.clearWorkforceData();
      case PrivacyClearTarget.all:
        await _clearAllData();
    }
    await _repository.pruneBackups();
    if (target == PrivacyClearTarget.all) {
      await _alarmApplicationService.syncRollingWindow();
    }
  }

  Future<void> _clearAssistantConfiguration() async {
    final references = await _privacyDataStore.loadCredentialReferences();
    for (final reference in references) {
      await _secureCredentialService.delete(reference);
    }
    await _privacyDataStore.clearAssistantConfiguration();
  }

  Future<void> _clearAllData() async {
    final references = await _privacyDataStore.loadCredentialReferences();
    for (final reference in references) {
      await _secureCredentialService.delete(reference);
    }
    await _privacyDataStore.clearAllData();
  }
}
