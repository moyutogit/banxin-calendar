import 'dart:convert';

import 'package:banxin_calendar/core/database/app_database.dart' as database;
import 'package:banxin_calendar/features/schedule/domain/schedule_entities.dart';
import 'package:banxin_calendar/features/schedule/domain/schedule_rules.dart';
import 'package:banxin_calendar/features/schedule/domain/value_objects.dart';

final class ScheduleJsonCodec {
  const ScheduleJsonCodec();

  String encodeShiftSnapshot(ShiftSnapshot shift) {
    return jsonEncode(<String, Object?>{
      'id': shift.id.value,
      'name': shift.name,
      'shortName': shift.shortName,
      'startMinute': shift.startMinute,
      'endMinute': shift.endMinute,
      'crossDay': shift.crossDay,
      'unpaidBreakMinutes': shift.unpaidBreakMinutes,
      'plannedPaidMinutes': shift.plannedPaidMinutes,
      'colorArgb': shift.colorArgb,
      'isWorkday': shift.isWorkday,
    });
  }

  ShiftSnapshot decodeShiftSnapshot(String source) {
    final json = _decodeObject(source);
    return ShiftSnapshot(
      id: ShiftId(_readString(json, 'id')),
      name: _readString(json, 'name'),
      shortName: _readString(json, 'shortName'),
      startMinute: _readInt(json, 'startMinute'),
      endMinute: _readInt(json, 'endMinute'),
      crossDay: _readBool(json, 'crossDay'),
      unpaidBreakMinutes: _readInt(json, 'unpaidBreakMinutes'),
      plannedPaidMinutes: _readInt(json, 'plannedPaidMinutes'),
      colorArgb: _readInt(json, 'colorArgb'),
      isWorkday: _readBool(json, 'isWorkday'),
    );
  }

  ScheduleRule decodeRule(
    database.ScheduleRule row,
    Map<String, ShiftSnapshot> shifts,
  ) {
    final payload = _decodeObject(row.cyclePayloadJson);
    final effectiveEnd = row.effectiveEnd ?? '9999-12-31';
    final common = (
      id: RuleId(row.id),
      name: row.name,
      effectiveRange: DateRange(
        start: LocalDate.parse(row.effectiveStart),
        end: LocalDate.parse(effectiveEnd),
      ),
      priority: row.priority,
    );

    switch (row.ruleType) {
      case 'weekly':
        return WeeklyScheduleRule(
          id: common.id,
          name: common.name,
          effectiveRange: common.effectiveRange,
          priority: common.priority,
          week: _decodeWeek(payload, 'days', shifts),
        );
      case 'cycle':
        final cycle = _decodeTemplates(payload, 'days', shifts);
        if (row.cycleLengthDays != cycle.length) {
          throw FormatException(
            'Rule ${row.id} cycle length does not match its payload.',
          );
        }
        return CycleScheduleRule(
          id: common.id,
          name: common.name,
          effectiveRange: common.effectiveRange,
          priority: common.priority,
          anchorDate: LocalDate.parse(row.anchorDate),
          cycle: cycle,
        );
      case 'alternating_week':
        return AlternatingWeekScheduleRule(
          id: common.id,
          name: common.name,
          effectiveRange: common.effectiveRange,
          priority: common.priority,
          anchorWeekStart: LocalDate.parse(row.anchorDate),
          anchorWeek: _decodeWeek(payload, 'anchorWeek', shifts),
          alternateWeek: _decodeWeek(payload, 'alternateWeek', shifts),
        );
      default:
        throw FormatException(
          'Unsupported schedule rule type: ${row.ruleType}',
        );
    }
  }

  EncodedScheduleRule encodeRule(ScheduleRule rule) {
    if (rule is WeeklyScheduleRule) {
      return EncodedScheduleRule(
        ruleType: 'weekly',
        anchorDate: rule.effectiveRange.start,
        cycleLengthDays: null,
        payloadJson: jsonEncode(<String, Object?>{
          'days': _encodeWeek(rule.week),
        }),
      );
    }
    if (rule is CycleScheduleRule) {
      return EncodedScheduleRule(
        ruleType: 'cycle',
        anchorDate: rule.anchorDate,
        cycleLengthDays: rule.cycle.length,
        payloadJson: jsonEncode(<String, Object?>{
          'days': rule.cycle.map(_encodeTemplate).toList(growable: false),
        }),
      );
    }
    if (rule is AlternatingWeekScheduleRule) {
      return EncodedScheduleRule(
        ruleType: 'alternating_week',
        anchorDate: rule.anchorWeekStart,
        cycleLengthDays: 14,
        payloadJson: jsonEncode(<String, Object?>{
          'anchorWeek': _encodeWeek(rule.anchorWeek),
          'alternateWeek': _encodeWeek(rule.alternateWeek),
        }),
      );
    }
    throw ArgumentError.value(rule, 'rule', 'Unsupported schedule rule type.');
  }

  DayStatus decodeDayStatus(String value) => _decodeStatus(value);

  List<Map<String, Object?>> _encodeWeek(WeekTemplate week) {
    return <Map<String, Object?>>[
      for (var weekday = DateTime.monday; weekday <= DateTime.sunday; weekday++)
        _encodeTemplate(week.forWeekday(weekday)),
    ];
  }

  Map<String, Object?> _encodeTemplate(ScheduleDayTemplate template) {
    return <String, Object?>{
      'status': template.status.name,
      if (template.shift != null) 'shiftId': template.shift!.id.value,
    };
  }

  WeekTemplate _decodeWeek(
    Map<String, Object?> payload,
    String key,
    Map<String, ShiftSnapshot> shifts,
  ) {
    final templates = _decodeTemplates(payload, key, shifts);
    if (templates.length != DateTime.daysPerWeek) {
      throw FormatException('$key must contain exactly seven days.');
    }
    return WeekTemplate(<int, ScheduleDayTemplate>{
      for (var index = 0; index < templates.length; index++)
        index + DateTime.monday: templates[index],
    });
  }

  List<ScheduleDayTemplate> _decodeTemplates(
    Map<String, Object?> payload,
    String key,
    Map<String, ShiftSnapshot> shifts,
  ) {
    final value = payload[key];
    if (value is! List<Object?>) {
      throw FormatException('$key must be an array.');
    }
    return List<ScheduleDayTemplate>.unmodifiable(
      value.map((item) {
        if (item is! Map<String, Object?>) {
          throw FormatException('$key contains an invalid day template.');
        }
        final statusName = _readString(item, 'status');
        final status = _decodeStatus(statusName);
        final shiftId = item['shiftId'];
        final shift = shiftId == null
            ? null
            : shifts[_expectString(shiftId, 'shiftId')];
        if (shiftId != null && shift == null) {
          throw FormatException('Unknown shift template: $shiftId');
        }
        return ScheduleDayTemplate(status: status, shift: shift);
      }),
    );
  }

  Map<String, Object?> _decodeObject(String source) {
    final value = jsonDecode(source);
    if (value is! Map<String, Object?>) {
      throw const FormatException('Expected a JSON object.');
    }
    return value;
  }

  DayStatus _decodeStatus(String value) {
    try {
      return DayStatus.values.byName(value);
    } on ArgumentError {
      throw FormatException('Unsupported day status: $value');
    }
  }

  String _readString(Map<String, Object?> json, String key) {
    return _expectString(json[key], key);
  }

  String _expectString(Object? value, String key) {
    if (value is! String || value.isEmpty) {
      throw FormatException('$key must be a non-empty string.');
    }
    return value;
  }

  int _readInt(Map<String, Object?> json, String key) {
    final value = json[key];
    if (value is! int) {
      throw FormatException('$key must be an integer.');
    }
    return value;
  }

  bool _readBool(Map<String, Object?> json, String key) {
    final value = json[key];
    if (value is! bool) {
      throw FormatException('$key must be a boolean.');
    }
    return value;
  }
}

final class EncodedScheduleRule {
  const EncodedScheduleRule({
    required this.ruleType,
    required this.anchorDate,
    required this.cycleLengthDays,
    required this.payloadJson,
  });

  final String ruleType;
  final LocalDate anchorDate;
  final int? cycleLengthDays;
  final String payloadJson;
}
