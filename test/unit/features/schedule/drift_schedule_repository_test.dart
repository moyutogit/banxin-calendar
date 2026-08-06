import 'dart:convert';

import 'package:banxin_calendar/core/database/app_database.dart';
import 'package:banxin_calendar/features/schedule/data/drift_schedule_repository.dart';
import 'package:banxin_calendar/features/schedule/domain/schedule_entities.dart';
import 'package:banxin_calendar/features/schedule/domain/value_objects.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DriftScheduleRepository', () {
    late AppDatabase database;
    late DriftScheduleRepository repository;

    setUp(() async {
      database = AppDatabase.inMemory();
      repository = DriftScheduleRepository(database);
      await database.ensureReady();
      await _insertWorkShift(database);
    });

    tearDown(() => database.close());

    test('maps active rules, overrides, holidays, and snapshots', () async {
      final weeklyPayload = jsonEncode(<String, Object?>{
        'days': <Object?>[
          for (var weekday = 1; weekday <= DateTime.daysPerWeek; weekday++)
            <String, Object?>{
              'status': weekday < DateTime.saturday ? 'work' : 'rest',
              if (weekday < DateTime.saturday) 'shiftId': 'day-shift',
            },
        ],
      });
      await _insertRule(
        database,
        id: 'weekday-rule',
        type: 'weekly',
        payload: weeklyPayload,
      );

      await database.customStatement(
        '''
        INSERT INTO day_overrides (
          id, work_date, status, shift_template_id, shift_snapshot_json,
          override_type, reason, note, created_at, updated_at, deleted_at
        ) VALUES (?, ?, ?, ?, ?, ?, NULL, NULL, 1, 1, NULL)
        ''',
        <Object?>['user-rest', '2026-08-03', 'rest', null, null, 'user'],
      );
      await database.customStatement(
        '''
        INSERT INTO day_overrides (
          id, work_date, status, shift_template_id, shift_snapshot_json,
          override_type, reason, note, created_at, updated_at, deleted_at
        ) VALUES (?, ?, ?, ?, ?, ?, NULL, NULL, 1, 1, NULL)
        ''',
        <Object?>[
          'company-work',
          '2026-08-08',
          'work',
          'day-shift',
          jsonEncode(<String, Object?>{
            'id': 'day-shift',
            'name': '历史白班',
            'shortName': '旧',
            'startMinute': 510,
            'endMinute': 1050,
            'crossDay': false,
            'unpaidBreakMinutes': 60,
            'plannedPaidMinutes': 480,
            'colorArgb': 0xFF334455,
            'isWorkday': true,
          }),
          'company',
        ],
      );
      await database.customStatement('''
        INSERT INTO holiday_records (
          work_date, region, name, day_type, data_version, published_at,
          updated_at
        ) VALUES ('2026-08-15', 'CN', '调休', 'adjusted_workday', 'fixture', 1, 1)
        ''');

      final range = DateRange(
        start: LocalDate.parse('2026-08-01'),
        end: LocalDate.parse('2026-08-31'),
      );
      final shifts = await repository.loadEnabledShifts();
      final rules = await repository.loadRules(range);
      final userOverrides = await repository.loadUserOverrides(range);
      final companyOverrides = await repository.loadCompanyOverrides(range);
      final holidays = await repository.loadOfficialHolidays(range);

      expect(shifts.single.name, '白班');
      expect(
        rules.single.evaluate(LocalDate.parse('2026-08-03')).status,
        DayStatus.work,
      );
      expect(
        rules.single.evaluate(LocalDate.parse('2026-08-09')).status,
        DayStatus.rest,
      );
      expect(
        userOverrides[LocalDate.parse('2026-08-03')]?.status,
        DayStatus.rest,
      );
      expect(
        companyOverrides[LocalDate.parse('2026-08-08')]?.shift?.name,
        '历史白班',
      );
      expect(
        holidays[LocalDate.parse('2026-08-15')]?.status,
        DayStatus.adjustedWorkday,
      );
    });

    test('ignores disabled and soft-deleted business rows', () async {
      await _insertRule(
        database,
        id: 'disabled',
        type: 'cycle',
        payload: jsonEncode(<String, Object?>{
          'days': <Object?>[
            <String, Object?>{'status': 'rest'},
          ],
        }),
        enabled: 0,
        cycleLength: 1,
      );
      await database.customStatement('''
        INSERT INTO day_overrides (
          id, work_date, status, shift_template_id, shift_snapshot_json,
          override_type, reason, note, created_at, updated_at, deleted_at
        ) VALUES (
          'deleted', '2026-08-03', 'rest', NULL, NULL, 'user', NULL, NULL,
          1, 1, 2
        )
        ''');

      final range = DateRange(
        start: LocalDate.parse('2026-08-01'),
        end: LocalDate.parse('2026-08-31'),
      );

      expect(await repository.loadRules(range), isEmpty);
      expect(await repository.loadUserOverrides(range), isEmpty);
    });

    test('rejects a persisted cycle whose declared length is wrong', () async {
      await _insertRule(
        database,
        id: 'invalid-cycle',
        type: 'cycle',
        payload: jsonEncode(<String, Object?>{
          'days': <Object?>[
            <String, Object?>{'status': 'rest'},
            <String, Object?>{'status': 'work', 'shiftId': 'day-shift'},
          ],
        }),
        cycleLength: 3,
      );

      final range = DateRange(
        start: LocalDate.parse('2026-08-01'),
        end: LocalDate.parse('2026-08-31'),
      );

      await expectLater(repository.loadRules(range), throwsFormatException);
    });
  });
}

Future<void> _insertWorkShift(AppDatabase database) {
  return database.customStatement('''
    INSERT INTO shift_templates (
      id, name, short_name, start_minute, end_minute, cross_day,
      unpaid_break_minutes, planned_paid_minutes, color_argb, is_workday,
      enabled, created_at, updated_at, deleted_at
    ) VALUES (
      'day-shift', '白班', '白', 540, 1080, 0, 60, 480, 4282992969,
      1, 1, 1, 1, NULL
    )
  ''');
}

Future<void> _insertRule(
  AppDatabase database, {
  required String id,
  required String type,
  required String payload,
  int enabled = 1,
  int? cycleLength,
}) {
  return database.customStatement(
    '''
    INSERT INTO schedule_rules (
      id, name, rule_type, anchor_date, cycle_length_days,
      cycle_payload_json, effective_start, effective_end, priority, enabled,
      created_at, updated_at, deleted_at
    ) VALUES (?, ?, ?, '2026-08-03', ?, ?, '2026-01-01', NULL, 10, ?, 1, 1, NULL)
    ''',
    <Object?>[id, id, type, cycleLength, payload, enabled],
  );
}
