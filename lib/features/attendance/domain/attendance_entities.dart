import 'package:banxin_calendar/features/schedule/domain/value_objects.dart';

enum AttendanceSource { punch, manual }

enum AttendanceEditReason { forgot, deviceIssue, correction, other }

enum AttendanceRecordStatus { complete, incomplete }

enum MinuteRoundingMode { none, floor, nearest, ceil }

final class AttendanceSegment {
  AttendanceSegment({
    required this.id,
    required this.workDate,
    required this.clockInUtc,
    required this.clockOutUtc,
    required this.unpaidBreakMinutes,
    required this.source,
    required this.status,
    required this.createdTimezone,
    required this.confirmed,
    this.editReason,
    this.note,
  }) {
    if (unpaidBreakMinutes < 0 || unpaidBreakMinutes > 1440) {
      throw ArgumentError.value(unpaidBreakMinutes, 'unpaidBreakMinutes');
    }
    if (note != null && note!.length > 500) {
      throw ArgumentError.value(note, 'note', 'Must be at most 500 chars.');
    }
    final complete = clockInUtc != null && clockOutUtc != null;
    if (status == AttendanceRecordStatus.complete && !complete) {
      throw ArgumentError('A complete segment requires both timestamps.');
    }
    if (complete) {
      if (!clockOutUtc!.isAfter(clockInUtc!)) {
        throw ArgumentError('Clock-out must be after clock-in.');
      }
      final total = clockOutUtc!.difference(clockInUtc!).inMinutes;
      if (total > 1440) {
        throw ArgumentError('A segment cannot exceed 24 hours.');
      }
      if (unpaidBreakMinutes > total) {
        throw ArgumentError('Unpaid break cannot exceed segment duration.');
      }
    }
  }

  final String id;
  final LocalDate workDate;
  final DateTime? clockInUtc;
  final DateTime? clockOutUtc;
  final int unpaidBreakMinutes;
  final AttendanceSource source;
  final AttendanceRecordStatus status;
  final AttendanceEditReason? editReason;
  final String? note;
  final String createdTimezone;
  final bool confirmed;

  bool get isComplete => clockInUtc != null && clockOutUtc != null;

  int get rawPaidMinutes => isComplete
      ? (clockOutUtc!.difference(clockInUtc!).inMinutes - unpaidBreakMinutes)
            .clamp(0, 1440)
      : 0;
}

final class WorkTimePolicy {
  const WorkTimePolicy({
    this.normalLimitMinutes = 480,
    this.minimumOvertimeMinutes = 0,
    this.lateToleranceMinutes = 0,
    this.earlyLeaveToleranceMinutes = 0,
    this.roundingMode = MinuteRoundingMode.none,
    this.roundingIncrementMinutes = 1,
  });

  final int normalLimitMinutes;
  final int minimumOvertimeMinutes;
  final int lateToleranceMinutes;
  final int earlyLeaveToleranceMinutes;
  final MinuteRoundingMode roundingMode;
  final int roundingIncrementMinutes;
}

final class DailyHours {
  const DailyHours({
    required this.rawActualMinutes,
    required this.payableMinutes,
    required this.normalMinutes,
    required this.overtimeMinutes,
    required this.missingPunch,
    required this.late,
    required this.earlyLeave,
  });

  final int rawActualMinutes;
  final int payableMinutes;
  final int normalMinutes;
  final int overtimeMinutes;
  final bool missingPunch;
  final bool late;
  final bool earlyLeave;
}
