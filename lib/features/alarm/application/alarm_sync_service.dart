import 'package:banxin_calendar/core/time/app_clock.dart';
import 'package:banxin_calendar/features/alarm/domain/alarm_entities.dart';
import 'package:banxin_calendar/features/alarm/domain/alarm_planner.dart';
import 'package:banxin_calendar/features/alarm/domain/alarm_repository.dart';
import 'package:banxin_calendar/features/alarm/domain/platform_alarm_service.dart';
import 'package:banxin_calendar/features/schedule/application/schedule_application_service.dart';
import 'package:banxin_calendar/features/schedule/domain/value_objects.dart';

final class AlarmSyncService {
  const AlarmSyncService(
    this._repository,
    this._platform,
    this._scheduleService, {
    this._planner = const AlarmPlanner(),
    this._clock = const SystemAppClock(),
  });

  final AlarmRepository _repository;
  final PlatformAlarmService _platform;
  final ScheduleApplicationService _scheduleService;
  final AlarmPlanner _planner;
  final AppClock _clock;

  Future<AlarmSyncResult> sync(DateRange range) async {
    final now = _clock.nowUtc();
    final templates = await _repository.loadTemplates(enabledOnly: true);
    final calendar = await _scheduleService.loadCalendar(range);
    final desired = _planner.build(
      days: calendar.days,
      templates: templates,
      nowUtc: now,
    );
    final existing = await _repository.loadInstances(range);
    final existingById = <String, AlarmInstance>{
      for (final instance in existing) instance.platformAlarmId: instance,
    };
    final desiredById = <String, PlannedAlarm>{
      for (final alarm in desired) alarm.instance.platformAlarmId: alarm,
    };
    final managedIds = await _safeManagedIds();
    final capability = await _safeCapability();
    final canceledIds = <String>{};
    final upserted = <AlarmInstance>[];
    var created = 0;
    var kept = 0;
    var failed = 0;
    var adjustedWithin24Hours = false;

    for (final existingAlarm in existing) {
      final desiredAlarm = desiredById[existingAlarm.platformAlarmId];
      final unchanged =
          desiredAlarm != null &&
          desiredAlarm.instance.payloadHash == existingAlarm.payloadHash;
      if ((unchanged && managedIds.contains(existingAlarm.platformAlarmId)) ||
          existingAlarm.locked) {
        kept++;
        continue;
      }
      if (managedIds.contains(existingAlarm.platformAlarmId)) {
        try {
          await _platform.cancel(existingAlarm.platformAlarmId);
        } catch (_) {
          // Persistence still records the desired state and a later self-check
          // reconciles orphaned platform alarms.
        }
      }
      canceledIds.add(existingAlarm.platformAlarmId);
      if (existingAlarm.triggerAtUtc.isBefore(
        now.add(const Duration(hours: 24)),
      )) {
        adjustedWithin24Hours = true;
      }
    }

    for (final orphanId in managedIds.difference(existingById.keys.toSet())) {
      try {
        await _platform.cancel(orphanId);
      } catch (_) {
        // Retried by the next self-check.
      }
    }

    for (final planned in desired) {
      final existingAlarm = existingById[planned.instance.platformAlarmId];
      final unchanged =
          existingAlarm != null &&
          existingAlarm.payloadHash == planned.instance.payloadHash &&
          managedIds.contains(planned.instance.platformAlarmId);
      if (unchanged || existingAlarm?.locked == true) {
        continue;
      }
      if (capability != AlarmCapability.available) {
        failed++;
        upserted.add(
          _failed(
            planned.instance,
            now,
            capability == AlarmCapability.permissionRequired
                ? 'permission_required'
                : 'platform_unavailable',
          ),
        );
        continue;
      }
      try {
        await _platform.schedule(planned.request);
        created++;
        upserted.add(
          _copy(
            planned.instance,
            status: AlarmInstanceStatus.scheduled,
            lastSyncedAtUtc: now,
          ),
        );
      } catch (error) {
        failed++;
        upserted.add(
          _failed(planned.instance, now, error.runtimeType.toString()),
        );
      }
    }

    await _repository.saveSyncChanges(
      upserted: upserted,
      canceledPlatformIds: canceledIds,
    );
    return AlarmSyncResult(
      capability: capability,
      created: created,
      kept: kept,
      canceled: canceledIds.length,
      failed: failed,
      adjustedWithin24Hours: adjustedWithin24Hours,
    );
  }

  Future<AlarmCapability> capability() => _safeCapability();

  Future<AlarmCapability> requestCapability() => _platform.requestCapability();

  Future<AlarmCapability> _safeCapability() async {
    try {
      return await _platform.capability();
    } catch (_) {
      return AlarmCapability.unavailable;
    }
  }

  Future<Set<String>> _safeManagedIds() async {
    try {
      return await _platform.listManagedAlarmIds();
    } catch (_) {
      return const <String>{};
    }
  }

  AlarmInstance _failed(AlarmInstance source, DateTime now, String errorCode) {
    final retryCount = source.retryCount + 1;
    final delayMinutes = (1 << retryCount.clamp(0, 10)).clamp(2, 1440);
    return _copy(
      source,
      status: AlarmInstanceStatus.failed,
      errorCode: errorCode,
      retryCount: retryCount,
      nextRetryAtUtc: now.add(Duration(minutes: delayMinutes)),
      lastSyncedAtUtc: now,
    );
  }

  AlarmInstance _copy(
    AlarmInstance source, {
    required AlarmInstanceStatus status,
    String? errorCode,
    int? retryCount,
    DateTime? nextRetryAtUtc,
    DateTime? lastSyncedAtUtc,
  }) => AlarmInstance(
    id: source.id,
    templateId: source.templateId,
    scheduleDate: source.scheduleDate,
    triggerAtUtc: source.triggerAtUtc,
    shiftId: source.shiftId,
    locked: source.locked,
    platformAlarmId: source.platformAlarmId,
    status: status,
    payloadHash: source.payloadHash,
    errorCode: errorCode,
    retryCount: retryCount ?? source.retryCount,
    nextRetryAtUtc: nextRetryAtUtc,
    lastSyncedAtUtc: lastSyncedAtUtc,
  );
}
