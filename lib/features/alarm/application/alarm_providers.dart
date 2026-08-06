import 'package:banxin_calendar/core/database/database_providers.dart';
import 'package:banxin_calendar/features/alarm/application/alarm_application_service.dart';
import 'package:banxin_calendar/features/alarm/application/alarm_sync_service.dart';
import 'package:banxin_calendar/features/alarm/data/drift_alarm_repository.dart';
import 'package:banxin_calendar/features/alarm/domain/alarm_repository.dart';
import 'package:banxin_calendar/features/alarm/domain/platform_alarm_service.dart';
import 'package:banxin_calendar/features/schedule/application/schedule_providers.dart';
import 'package:banxin_calendar/platform/alarm_bridge.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final alarmRepositoryProvider = Provider<AlarmRepository>(
  (ref) => DriftAlarmRepository(ref.watch(appDatabaseProvider)),
);

final platformAlarmServiceProvider = Provider<PlatformAlarmService>(
  (ref) => MethodChannelAlarmBridge(),
);

final alarmSyncServiceProvider = Provider<AlarmSyncService>(
  (ref) => AlarmSyncService(
    ref.watch(alarmRepositoryProvider),
    ref.watch(platformAlarmServiceProvider),
    ref.watch(scheduleApplicationServiceProvider),
  ),
);

final alarmApplicationServiceProvider = Provider<AlarmApplicationService>(
  (ref) => AlarmApplicationService(
    ref.watch(alarmRepositoryProvider),
    ref.watch(alarmSyncServiceProvider),
    ref.watch(scheduleApplicationServiceProvider),
  ),
);
