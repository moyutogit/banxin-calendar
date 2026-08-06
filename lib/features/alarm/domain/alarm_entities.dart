import 'package:banxin_calendar/features/schedule/domain/value_objects.dart';

enum AlarmTemplateMode { fixedTime, relativeToShiftStart }

enum AlarmInstanceStatus { scheduled, failed, triggered, canceled }

enum AlarmCapability { available, permissionRequired, unavailable }

final class AlarmTemplate {
  AlarmTemplate({
    required this.id,
    required this.name,
    required this.mode,
    required this.vibrate,
    required this.volumeRamp,
    required this.snoozeMinutes,
    required this.maxSnoozeCount,
    required this.enabled,
    required this.shiftIds,
    this.fixedMinute,
    this.offsetMinutes,
    this.soundId,
  }) {
    if (name.trim().isEmpty || name.length > 20) {
      throw ArgumentError.value(name, 'name', 'Must contain 1-20 characters.');
    }
    if (mode == AlarmTemplateMode.fixedTime &&
        (fixedMinute == null || fixedMinute! < 0 || fixedMinute! >= 1440)) {
      throw ArgumentError.value(fixedMinute, 'fixedMinute');
    }
    if (mode == AlarmTemplateMode.relativeToShiftStart &&
        (offsetMinutes == null ||
            offsetMinutes! < -1440 ||
            offsetMinutes! > 1440)) {
      throw ArgumentError.value(offsetMinutes, 'offsetMinutes');
    }
    if (snoozeMinutes < 1 || snoozeMinutes > 60) {
      throw ArgumentError.value(snoozeMinutes, 'snoozeMinutes');
    }
    if (maxSnoozeCount < 0 || maxSnoozeCount > 10) {
      throw ArgumentError.value(maxSnoozeCount, 'maxSnoozeCount');
    }
    if (shiftIds.length > 5) {
      throw ArgumentError.value(shiftIds, 'shiftIds', 'At most 5 shifts.');
    }
  }

  final String id;
  final String name;
  final AlarmTemplateMode mode;
  final int? fixedMinute;
  final int? offsetMinutes;
  final String? soundId;
  final bool vibrate;
  final bool volumeRamp;
  final int snoozeMinutes;
  final int maxSnoozeCount;
  final bool enabled;
  final Set<ShiftId> shiftIds;
}

final class AlarmInstance {
  const AlarmInstance({
    required this.id,
    required this.templateId,
    required this.scheduleDate,
    required this.triggerAtUtc,
    required this.shiftId,
    required this.locked,
    required this.platformAlarmId,
    required this.status,
    required this.payloadHash,
    required this.retryCount,
    this.errorCode,
    this.nextRetryAtUtc,
    this.lastSyncedAtUtc,
  });

  final String id;
  final String templateId;
  final LocalDate scheduleDate;
  final DateTime triggerAtUtc;
  final ShiftId? shiftId;
  final bool locked;
  final String platformAlarmId;
  final AlarmInstanceStatus status;
  final String payloadHash;
  final String? errorCode;
  final int retryCount;
  final DateTime? nextRetryAtUtc;
  final DateTime? lastSyncedAtUtc;
}

final class PlatformAlarmRequest {
  const PlatformAlarmRequest({
    required this.platformAlarmId,
    required this.triggerAtUtc,
    required this.payloadHash,
    required this.title,
    required this.body,
    required this.vibrate,
    required this.soundId,
  });

  final String platformAlarmId;
  final DateTime triggerAtUtc;
  final String payloadHash;
  final String title;
  final String body;
  final bool vibrate;
  final String? soundId;
}

final class AlarmSyncResult {
  const AlarmSyncResult({
    required this.capability,
    required this.created,
    required this.kept,
    required this.canceled,
    required this.failed,
    required this.adjustedWithin24Hours,
  });

  final AlarmCapability capability;
  final int created;
  final int kept;
  final int canceled;
  final int failed;
  final bool adjustedWithin24Hours;

  bool get succeeded => failed == 0 && capability == AlarmCapability.available;
}
