import 'package:banxin_calendar/features/attendance/domain/attendance_engine.dart';
import 'package:banxin_calendar/features/attendance/domain/attendance_entities.dart';
import 'package:banxin_calendar/features/schedule/domain/value_objects.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const engine = AttendanceEngine();
  final date = LocalDate.parse('2026-08-10');

  test('09:00-18:00 with a 60-minute break produces 8 paid hours', () {
    final result = engine.calculate(
      segments: <AttendanceSegment>[
        _segment(
          id: 'day',
          date: date,
          start: DateTime.utc(2026, 8, 10, 9),
          end: DateTime.utc(2026, 8, 10, 18),
          breakMinutes: 60,
        ),
      ],
      policy: const WorkTimePolicy(normalLimitMinutes: 480),
    );

    expect(result.rawActualMinutes, 480);
    expect(result.normalMinutes, 480);
    expect(result.overtimeMinutes, 0);
  });

  test('an incomplete punch is marked missing and creates no actual time', () {
    final result = engine.calculate(
      segments: <AttendanceSegment>[
        AttendanceSegment(
          id: 'missing',
          workDate: date,
          clockInUtc: DateTime.utc(2026, 8, 10, 9),
          clockOutUtc: null,
          unpaidBreakMinutes: 0,
          source: AttendanceSource.punch,
          status: AttendanceRecordStatus.incomplete,
          createdTimezone: 'Asia/Shanghai',
          confirmed: false,
        ),
      ],
      policy: const WorkTimePolicy(),
    );

    expect(result.missingPunch, isTrue);
    expect(result.rawActualMinutes, 0);
  });

  test('multiple segments are summed and overlaps are rejected', () {
    final morning = _segment(
      id: 'morning',
      date: date,
      start: DateTime.utc(2026, 8, 10, 9),
      end: DateTime.utc(2026, 8, 10, 12),
    );
    final afternoon = _segment(
      id: 'afternoon',
      date: date,
      start: DateTime.utc(2026, 8, 10, 13),
      end: DateTime.utc(2026, 8, 10, 18),
    );
    expect(
      engine
          .calculate(
            segments: <AttendanceSegment>[morning, afternoon],
            policy: const WorkTimePolicy(),
          )
          .rawActualMinutes,
      480,
    );

    expect(
      () => engine.calculate(
        segments: <AttendanceSegment>[
          morning,
          _segment(
            id: 'overlap',
            date: date,
            start: DateTime.utc(2026, 8, 10, 11),
            end: DateTime.utc(2026, 8, 10, 14),
          ),
        ],
        policy: const WorkTimePolicy(),
      ),
      throwsArgumentError,
    );
  });

  test('cross-night work remains assigned to its explicit work date', () {
    final result = engine.calculate(
      segments: <AttendanceSegment>[
        _segment(
          id: 'night',
          date: date,
          start: DateTime.utc(2026, 8, 10, 20),
          end: DateTime.utc(2026, 8, 11, 8),
          breakMinutes: 60,
        ),
      ],
      policy: const WorkTimePolicy(normalLimitMinutes: 480),
    );

    expect(result.rawActualMinutes, 660);
    expect(result.normalMinutes, 480);
    expect(result.overtimeMinutes, 180);
  });

  test('rounding changes payable time but retains raw minutes', () {
    final result = engine.calculate(
      segments: <AttendanceSegment>[
        _segment(
          id: 'round',
          date: date,
          start: DateTime.utc(2026, 8, 10, 9),
          end: DateTime.utc(2026, 8, 10, 17, 58),
        ),
      ],
      policy: const WorkTimePolicy(
        roundingMode: MinuteRoundingMode.floor,
        roundingIncrementMinutes: 15,
      ),
    );
    expect(result.rawActualMinutes, 538);
    expect(result.payableMinutes, 525);
  });
}

AttendanceSegment _segment({
  required String id,
  required LocalDate date,
  required DateTime start,
  required DateTime end,
  int breakMinutes = 0,
}) => AttendanceSegment(
  id: id,
  workDate: date,
  clockInUtc: start,
  clockOutUtc: end,
  unpaidBreakMinutes: breakMinutes,
  source: AttendanceSource.manual,
  status: AttendanceRecordStatus.complete,
  editReason: AttendanceEditReason.correction,
  createdTimezone: 'Asia/Shanghai',
  confirmed: true,
);
