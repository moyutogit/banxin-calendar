import 'dart:convert';

import 'package:banxin_calendar/core/database/app_database.dart';
import 'package:banxin_calendar/core/ids/stable_id_generator.dart';
import 'package:banxin_calendar/core/time/app_clock.dart';
import 'package:banxin_calendar/features/schedule/data/drift_schedule_repository.dart';
import 'package:banxin_calendar/features/schedule/domain/schedule_entities.dart';
import 'package:banxin_calendar/features/schedule/domain/schedule_resolver.dart';
import 'package:banxin_calendar/features/schedule/domain/schedule_rules.dart';
import 'package:banxin_calendar/features/schedule/domain/value_objects.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../fixtures/schedule_fixtures.dart';

void main() {
  group('DriftScheduleRepository', () {
    late AppDatabase database;
    late DriftScheduleRepository repository;

    setUp(() async {
      database = AppDatabase.inMemory();
      repository = DriftScheduleRepository(
        database,
        clock: _FixedClock(),
        idGenerator: _SequenceIdGenerator(),
      );
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

    test(
      'saves rules atomically, invalidates cache, and writes audit',
      () async {
        final range = DateRange(
          start: LocalDate.parse('2026-08-01'),
          end: LocalDate.parse('2026-08-31'),
        );
        await repository.replaceCachedDays(
          days: <ResolvedCalendarDay>[
            ResolvedCalendarDay(
              date: LocalDate.parse('2026-08-03'),
              status: DayStatus.work,
              shift: dayShift(),
              source: DaySource.defaultRule,
              plannedPaidMinutes: 480,
              tags: const <DayTag>[],
              resolverVersion: ScheduleResolver.resolverVersion,
            ),
          ],
          inputVersion: '0',
        );
        final rule = WeeklyScheduleRule(
          id: RuleId('saved-week'),
          name: '双休',
          effectiveRange: range,
          priority: 10,
          week: standardFiveDayWeek(
            shift: (await repository.loadEnabledShifts()).single,
          ),
        );

        await repository.saveRule(rule, enabled: true);

        final stored = await repository.loadStoredRules();
        final cached = await repository.loadCachedDays(
          range: range,
          inputVersion: '0',
          resolverVersion: ScheduleResolver.resolverVersion,
        );
        final audit = await database.select(database.changeLog).get();

        expect(stored.single.rule.id, RuleId('saved-week'));
        expect(stored.single.enabled, isTrue);
        expect(cached, isEmpty);
        expect(await repository.loadInputVersion(), '1');
        expect(audit.single.entityType, 'schedule_rule');
        expect(audit.single.changeType, 'create');
      },
    );

    test('persists override snapshots and can restore rule results', () async {
      final shift = (await repository.loadEnabledShifts()).single;
      final date = LocalDate.parse('2026-08-08');
      final override = CalendarOverride(
        id: 'manual-work',
        date: date,
        status: DayStatus.work,
        shift: shift,
      );

      await repository.saveOverrides(<CalendarOverride>[
        override,
      ], source: DaySource.userOverride);

      final persisted = await repository.loadUserOverrides(
        DateRange(start: date, end: date),
      );
      expect(persisted[date]?.shift?.name, '白班');

      await database.customStatement(
        "UPDATE shift_templates SET name = '已修改模板' WHERE id = 'day-shift'",
      );
      final stillSnapshotted = await repository.loadUserOverrides(
        DateRange(start: date, end: date),
      );
      expect(stillSnapshotted[date]?.shift?.name, '白班');

      await repository.restoreOverrides(
        DateRange(start: date, end: date),
        source: DaySource.userOverride,
      );

      expect(
        await repository.loadUserOverrides(DateRange(start: date, end: date)),
        isEmpty,
      );
      final audit = await database.select(database.changeLog).get();
      expect(audit.map((row) => row.changeType), <String>[
        'create',
        'restore_rule_result',
      ]);
    });

    test('replaces holiday datasets and reports the exact diff', () async {
      final first = <HolidayImportRecord>[
        HolidayImportRecord(
          date: LocalDate.parse('2026-10-01'),
          name: '国庆节',
          status: DayStatus.publicHoliday,
        ),
        HolidayImportRecord(
          date: LocalDate.parse('2026-10-10'),
          name: '调休上班',
          status: DayStatus.adjustedWorkday,
        ),
      ];
      await repository.replaceOfficialHolidays(
        region: 'CN',
        dataVersion: 'v1',
        holidays: first,
        updatedAt: 1,
      );

      final summary = await repository.replaceOfficialHolidays(
        region: 'CN',
        dataVersion: 'v2',
        holidays: <HolidayImportRecord>[
          HolidayImportRecord(
            date: LocalDate.parse('2026-10-01'),
            name: '国庆假期',
            status: DayStatus.publicHoliday,
          ),
          HolidayImportRecord(
            date: LocalDate.parse('2026-10-02'),
            name: '国庆节',
            status: DayStatus.publicHoliday,
          ),
        ],
        updatedAt: 2,
      );

      expect(summary.added, 1);
      expect(summary.removed, 1);
      expect(summary.changed, 1);
      final loaded = await repository.loadOfficialHolidays(
        DateRange(
          start: LocalDate.parse('2026-10-01'),
          end: LocalDate.parse('2026-10-31'),
        ),
      );
      expect(loaded, hasLength(2));
      expect(
        loaded[LocalDate.parse('2026-10-02')]?.status,
        DayStatus.publicHoliday,
      );
    });

    test('rolls back the complete setup when its audit write fails', () async {
      await database.customStatement('''
        INSERT INTO change_log (
          id, entity_type, entity_id, change_type,
          before_snapshot_json, after_snapshot_json, created_at, updated_at
        ) VALUES ('audit-0', 'fixture', 'fixture', 'fixture', NULL, NULL, 1, 1)
      ''');
      final shift = dayShift(id: 'atomic-shift');
      final rule = WeeklyScheduleRule(
        id: RuleId('atomic-rule'),
        name: '原子配置',
        effectiveRange: DateRange(
          start: LocalDate.parse('2026-08-01'),
          end: LocalDate.parse('2026-12-31'),
        ),
        priority: 10,
        week: standardFiveDayWeek(shift: shift),
      );

      await expectLater(
        repository.saveScheduleSetup(shift: shift, rule: rule),
        throwsA(isA<Exception>()),
      );

      final shiftRows = await (database.select(
        database.shiftTemplates,
      )..where((table) => table.id.equals('atomic-shift'))).get();
      final ruleRows = await (database.select(
        database.scheduleRules,
      )..where((table) => table.id.equals('atomic-rule'))).get();
      expect(shiftRows, isEmpty);
      expect(ruleRows, isEmpty);
      expect(await repository.loadInputVersion(), '0');
    });

    test('prevents disabling a shift referenced by an active rule', () async {
      final shift = (await repository.loadEnabledShifts()).single;
      final rule = WeeklyScheduleRule(
        id: RuleId('protected-rule'),
        name: '引用班次的规则',
        effectiveRange: DateRange(
          start: LocalDate.parse('2026-08-01'),
          end: LocalDate.parse('2026-12-31'),
        ),
        priority: 10,
        week: standardFiveDayWeek(shift: shift),
      );
      await repository.saveRule(rule, enabled: true);

      await expectLater(
        repository.setShiftEnabled(shift.id, enabled: false),
        throwsA(isA<StateError>()),
      );
      expect((await repository.loadStoredShifts()).single.enabled, isTrue);

      await repository.setRuleEnabled(rule.id, enabled: false);
      await repository.setShiftEnabled(shift.id, enabled: false);
      expect((await repository.loadStoredShifts()).single.enabled, isFalse);
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

final class _FixedClock implements AppClock {
  @override
  DateTime nowUtc() => DateTime.utc(2026, 8, 6, 1, 2, 3);
}

final class _SequenceIdGenerator implements StableIdGenerator {
  var _next = 0;

  @override
  String generate() => 'audit-${_next++}';
}
