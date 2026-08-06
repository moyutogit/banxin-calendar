import 'package:banxin_calendar/core/database/database_providers.dart';
import 'package:banxin_calendar/core/secure_storage/secure_storage_providers.dart';
import 'package:banxin_calendar/features/alarm/application/alarm_providers.dart';
import 'package:banxin_calendar/features/backup/application/backup_application_service.dart';
import 'package:banxin_calendar/features/backup/data/drift_privacy_data_store.dart';
import 'package:banxin_calendar/features/backup/data/local_backup_repository.dart';
import 'package:banxin_calendar/features/backup/domain/backup_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final backupRepositoryProvider = Provider<BackupRepository>(
  (ref) => LocalBackupRepository(ref.watch(appDatabaseProvider)),
);

final privacyDataStoreProvider = Provider<PrivacyDataStore>(
  (ref) => DriftPrivacyDataStore(ref.watch(appDatabaseProvider)),
);

final backupApplicationServiceProvider = Provider<BackupApplicationService>(
  (ref) => BackupApplicationService(
    ref.watch(backupRepositoryProvider),
    ref.watch(privacyDataStoreProvider),
    ref.watch(secureCredentialServiceProvider),
    ref.watch(alarmApplicationServiceProvider),
  ),
);

final automaticBackupBootstrapProvider = FutureProvider<void>(
  (ref) =>
      ref.watch(backupApplicationServiceProvider).runAutomaticBackupIfNeeded(),
);
