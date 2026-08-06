import 'package:banxin_calendar/features/schedule/domain/schedule_entities.dart';
import 'package:banxin_calendar/features/schedule/domain/schedule_rules.dart';
import 'package:banxin_calendar/features/schedule/domain/value_objects.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../fixtures/schedule_fixtures.dart';

void main() {
  final wideRange = DateRange(
    start: LocalDate(2020, 1, 1),
    end: LocalDate(2030, 12, 31),
  );

  test('custom cycle normalizes negative offsets', () {
    final rule = CycleScheduleRule(
      id: RuleId('cycle'),
      name: '白白休',
      effectiveRange: wideRange,
      priority: 10,
      anchorDate: LocalDate(2026, 1, 10),
      cycle: <ScheduleDayTemplate>[
        workTemplate(),
        workTemplate(),
        restTemplate(),
      ],
    );

    expect(rule.evaluate(LocalDate(2026, 1, 10)).status, DayStatus.work);
    expect(rule.evaluate(LocalDate(2026, 1, 9)).status, DayStatus.rest);
    expect(rule.evaluate(LocalDate(2026, 1, 8)).status, DayStatus.work);
  });

  test('alternating week uses its anchor across a year boundary', () {
    final rule = AlternatingWeekScheduleRule(
      id: RuleId('alternating'),
      name: '大小周',
      effectiveRange: wideRange,
      priority: 20,
      anchorWeekStart: LocalDate(2025, 12, 29),
      anchorWeek: sixDayWeek(),
      alternateWeek: standardFiveDayWeek(),
    );

    expect(rule.evaluate(LocalDate(2026, 1, 3)).status, DayStatus.work);
    expect(rule.evaluate(LocalDate(2026, 1, 10)).status, DayStatus.rest);
    expect(rule.evaluate(LocalDate(2025, 12, 27)).status, DayStatus.rest);
  });

  test('alternating week rejects a non-Monday anchor', () {
    expect(
      () => AlternatingWeekScheduleRule(
        id: RuleId('invalid'),
        name: '错误锚点',
        effectiveRange: wideRange,
        priority: 1,
        anchorWeekStart: LocalDate(2026, 1, 1),
        anchorWeek: sixDayWeek(),
        alternateWeek: standardFiveDayWeek(),
      ),
      throwsArgumentError,
    );
  });
}
