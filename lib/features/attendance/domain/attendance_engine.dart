import 'dart:math';

import 'package:banxin_calendar/features/attendance/domain/attendance_entities.dart';

final class AttendanceEngine {
  const AttendanceEngine();

  DailyHours calculate({
    required List<AttendanceSegment> segments,
    required WorkTimePolicy policy,
    DateTime? plannedStartUtc,
    DateTime? plannedEndUtc,
  }) {
    _validateNoOverlap(segments);
    final complete = segments.where((segment) => segment.isComplete).toList();
    final raw = complete.fold<int>(
      0,
      (total, segment) => total + segment.rawPaidMinutes,
    );
    final payable = roundMinutes(
      raw,
      mode: policy.roundingMode,
      increment: policy.roundingIncrementMinutes,
    );
    final normal = min(payable, policy.normalLimitMinutes);
    var overtime = max(0, payable - policy.normalLimitMinutes);
    if (overtime < policy.minimumOvertimeMinutes) overtime = 0;
    final firstIn = complete
        .map((segment) => segment.clockInUtc!)
        .fold<DateTime?>(null, (value, time) {
          if (value == null || time.isBefore(value)) return time;
          return value;
        });
    final lastOut = complete
        .map((segment) => segment.clockOutUtc!)
        .fold<DateTime?>(null, (value, time) {
          if (value == null || time.isAfter(value)) return time;
          return value;
        });
    return DailyHours(
      rawActualMinutes: raw,
      payableMinutes: payable,
      normalMinutes: normal,
      overtimeMinutes: overtime,
      missingPunch: segments.any((segment) => !segment.isComplete),
      late:
          plannedStartUtc != null &&
          firstIn != null &&
          firstIn.isAfter(
            plannedStartUtc.add(Duration(minutes: policy.lateToleranceMinutes)),
          ),
      earlyLeave:
          plannedEndUtc != null &&
          lastOut != null &&
          lastOut.isBefore(
            plannedEndUtc.subtract(
              Duration(minutes: policy.earlyLeaveToleranceMinutes),
            ),
          ),
    );
  }

  int roundMinutes(
    int minutes, {
    required MinuteRoundingMode mode,
    required int increment,
  }) {
    if (minutes < 0) throw ArgumentError.value(minutes, 'minutes');
    if (increment < 1 || increment > 60) {
      throw ArgumentError.value(increment, 'increment');
    }
    if (mode == MinuteRoundingMode.none || minutes == 0) return minutes;
    final units = minutes / increment;
    return switch (mode) {
      MinuteRoundingMode.none => minutes,
      MinuteRoundingMode.floor => units.floor() * increment,
      MinuteRoundingMode.nearest => units.round() * increment,
      MinuteRoundingMode.ceil => units.ceil() * increment,
    };
  }

  void _validateNoOverlap(List<AttendanceSegment> segments) {
    final complete = segments.where((segment) => segment.isComplete).toList()
      ..sort((left, right) => left.clockInUtc!.compareTo(right.clockInUtc!));
    for (var index = 1; index < complete.length; index++) {
      if (complete[index].clockInUtc!.isBefore(
        complete[index - 1].clockOutUtc!,
      )) {
        throw ArgumentError('Attendance segments cannot overlap.');
      }
    }
  }
}
