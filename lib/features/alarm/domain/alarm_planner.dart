import 'dart:convert';

import 'package:banxin_calendar/features/alarm/domain/alarm_entities.dart';
import 'package:banxin_calendar/features/schedule/domain/schedule_entities.dart';

final class PlannedAlarm {
  const PlannedAlarm({required this.instance, required this.request});

  final AlarmInstance instance;
  final PlatformAlarmRequest request;
}

final class AlarmPlanner {
  const AlarmPlanner();

  List<PlannedAlarm> build({
    required List<ResolvedCalendarDay> days,
    required List<AlarmTemplate> templates,
    required DateTime nowUtc,
  }) {
    final planned = <PlannedAlarm>[];
    for (final day in days) {
      final shift = day.shift;
      if (shift == null ||
          (day.status != DayStatus.work &&
              day.status != DayStatus.adjustedWorkday)) {
        continue;
      }
      for (final template in templates) {
        if (!template.enabled || !template.shiftIds.contains(shift.id)) {
          continue;
        }
        final triggerAtUtc = _triggerAt(day, template).toUtc();
        if (!triggerAtUtc.isAfter(nowUtc)) {
          continue;
        }
        final identity = <Object?>[
          'banxin-calendar',
          day.date.toString(),
          shift.id.value,
          template.id,
          triggerAtUtc.millisecondsSinceEpoch,
        ].join('|');
        final platformId = 'banxin_${_fnv1a(identity)}';
        final payloadHash = _fnv1a(
          jsonEncode(<String, Object?>{
            'deliveryVersion': 2,
            'title': template.name,
            'body': '${shift.name} ${day.date}',
            'vibrate': template.vibrate,
            'soundId': template.soundId,
            'triggerAt': triggerAtUtc.millisecondsSinceEpoch,
          }),
        );
        final request = PlatformAlarmRequest(
          platformAlarmId: platformId,
          triggerAtUtc: triggerAtUtc,
          payloadHash: payloadHash,
          title: template.name,
          body: '${shift.name} · ${day.date}',
          vibrate: template.vibrate,
          soundId: template.soundId,
        );
        planned.add(
          PlannedAlarm(
            instance: AlarmInstance(
              id: platformId,
              templateId: template.id,
              scheduleDate: day.date,
              triggerAtUtc: triggerAtUtc,
              shiftId: shift.id,
              locked: false,
              platformAlarmId: platformId,
              status: AlarmInstanceStatus.scheduled,
              payloadHash: payloadHash,
              retryCount: 0,
            ),
            request: request,
          ),
        );
      }
    }
    planned.sort(
      (left, right) =>
          left.instance.triggerAtUtc.compareTo(right.instance.triggerAtUtc),
    );
    return List<PlannedAlarm>.unmodifiable(planned);
  }

  DateTime _triggerAt(ResolvedCalendarDay day, AlarmTemplate template) {
    final baseMinute = switch (template.mode) {
      AlarmTemplateMode.fixedTime => template.fixedMinute!,
      AlarmTemplateMode.relativeToShiftStart =>
        day.shift!.startMinute + template.offsetMinutes!,
    };
    return DateTime(
      day.date.year,
      day.date.month,
      day.date.day,
    ).add(Duration(minutes: baseMinute));
  }

  String _fnv1a(String input) {
    var hash = 0x811C9DC5;
    for (final byte in utf8.encode(input)) {
      hash ^= byte;
      hash = (hash * 0x01000193) & 0xFFFFFFFF;
    }
    return hash.toRadixString(16).padLeft(8, '0');
  }
}
