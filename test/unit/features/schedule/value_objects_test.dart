import 'package:banxin_calendar/features/schedule/domain/value_objects.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LocalDate', () {
    test('parses ISO dates and crosses leap-day boundaries', () {
      final leapDay = LocalDate.parse('2028-02-29');

      expect(leapDay.addDays(1).toString(), '2028-03-01');
      expect(LocalDate(2028, 2, 28).daysUntil(leapDay), 1);
    });

    test('rejects invalid and display-formatted dates', () {
      expect(() => LocalDate(2027, 2, 29), throwsArgumentError);
      expect(() => LocalDate.parse('2026/08/15'), throwsFormatException);
    });
  });

  test('DateRange is inclusive and validates ordering', () {
    final range = DateRange(
      start: LocalDate(2026, 8, 30),
      end: LocalDate(2026, 9, 1),
    );

    expect(range.dates.map((date) => date.toString()), <String>[
      '2026-08-30',
      '2026-08-31',
      '2026-09-01',
    ]);
    expect(
      () => DateRange(start: LocalDate(2026, 9, 2), end: LocalDate(2026, 9, 1)),
      throwsArgumentError,
    );
  });
}
