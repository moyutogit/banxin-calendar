import 'dart:convert';

import 'package:banxin_calendar/core/database/app_database.dart' as database;
import 'package:banxin_calendar/core/ids/stable_id_generator.dart';
import 'package:banxin_calendar/core/time/app_clock.dart';
import 'package:banxin_calendar/features/schedule/data/schedule_json_codec.dart';
import 'package:banxin_calendar/features/schedule/domain/schedule_entities.dart';
import 'package:banxin_calendar/features/schedule/domain/schedule_repository.dart';
import 'package:banxin_calendar/features/schedule/domain/schedule_rules.dart';
import 'package:banxin_calendar/features/schedule/domain/value_objects.dart';
import 'package:drift/drift.dart';

final class DriftScheduleRepository implements ScheduleRepository {
  DriftScheduleRepository(
    this._database, {
    this.holidayRegion = 'CN',
    this._codec = const ScheduleJsonCodec(),
    this._clock = const SystemAppClock(),
    StableIdGenerator? idGenerator,
  }) : _idGenerator = idGenerator ?? UuidV4Generator();

  static const String _inputVersionKey = 'schedule_input_version';
  static const String _holidayEnabledKey = 'official_holiday_enabled';

  final database.AppDatabase _database;
  final String holidayRegion;
  final ScheduleJsonCodec _codec;
  final AppClock _clock;
  final StableIdGenerator _idGenerator;

  @override
  Future<List<ShiftSnapshot>> loadEnabledShifts() async {
    final rows = await _loadWorkShiftRows(onlyEnabled: true);
    return List<ShiftSnapshot>.unmodifiable(rows.map(_mapShift));
  }

  @override
  Future<List<StoredShiftTemplate>> loadStoredShifts() async {
    final query = _database.select(_database.shiftTemplates)
      ..where((table) => table.deletedAt.isNull())
      ..orderBy(<OrderingTerm Function(database.$ShiftTemplatesTable)>[
        (table) => OrderingTerm.asc(table.name),
      ]);
    final rows = await query.get();
    return List<StoredShiftTemplate>.unmodifiable(
      rows.map(
        (row) => StoredShiftTemplate(
          shift: _mapShift(row),
          enabled: row.enabled == 1,
        ),
      ),
    );
  }

  @override
  Future<List<StoredScheduleRule>> loadStoredRules() async {
    final shifts = await _loadShiftMap();
    final query = _database.select(_database.scheduleRules)
      ..where((table) => table.deletedAt.isNull())
      ..orderBy(<OrderingTerm Function(database.$ScheduleRulesTable)>[
        (table) => OrderingTerm.desc(table.priority),
        (table) => OrderingTerm.asc(table.name),
      ]);
    final rows = await query.get();
    return List<StoredScheduleRule>.unmodifiable(
      rows.map(
        (row) => StoredScheduleRule(
          rule: _codec.decodeRule(row, shifts),
          enabled: row.enabled == 1,
        ),
      ),
    );
  }

  @override
  Future<List<ScheduleRule>> loadRules(DateRange range) async {
    final shifts = await _loadShiftMap();
    final query = _database.select(_database.scheduleRules)
      ..where(
        (table) =>
            table.enabled.equals(1) &
            table.deletedAt.isNull() &
            table.effectiveStart.isSmallerOrEqualValue(range.end.toString()) &
            (table.effectiveEnd.isNull() |
                table.effectiveEnd.isBiggerOrEqualValue(
                  range.start.toString(),
                )),
      );
    final rows = await query.get();
    return List<ScheduleRule>.unmodifiable(
      rows.map((row) => _codec.decodeRule(row, shifts)),
    );
  }

  @override
  Future<Map<LocalDate, CalendarOverride>> loadUserOverrides(DateRange range) {
    return _loadOverrides(range, 'user');
  }

  @override
  Future<Map<LocalDate, CalendarOverride>> loadCompanyOverrides(
    DateRange range,
  ) {
    return _loadOverrides(range, 'company');
  }

  @override
  Future<Map<LocalDate, OfficialHoliday>> loadOfficialHolidays(
    DateRange range,
  ) async {
    if (!await isOfficialHolidayEnabled()) {
      return const <LocalDate, OfficialHoliday>{};
    }
    final query = _database.select(_database.holidayRecords)
      ..where(
        (table) =>
            table.region.equals(holidayRegion) &
            table.workDate.isBiggerOrEqualValue(range.start.toString()) &
            table.workDate.isSmallerOrEqualValue(range.end.toString()),
      );
    final rows = await query.get();
    return Map<LocalDate, OfficialHoliday>.unmodifiable(
      <LocalDate, OfficialHoliday>{
        for (final row in rows)
          LocalDate.parse(row.workDate): OfficialHoliday(
            id: '${row.region}:${row.workDate}',
            date: LocalDate.parse(row.workDate),
            status: _decodeHolidayStatus(row.dayType),
          ),
      },
    );
  }

  @override
  Future<bool> isOfficialHolidayEnabled() async {
    final query = _database.select(_database.databaseMetadata)
      ..where((table) => table.key.equals(_holidayEnabledKey));
    return (await query.getSingleOrNull())?.value != '0';
  }

  @override
  Future<void> setOfficialHolidayEnabled({required bool enabled}) async {
    final now = _nowMillis;
    await _database.transaction(() async {
      final query = _database.select(_database.databaseMetadata)
        ..where((table) => table.key.equals(_holidayEnabledKey));
      final existing = await query.getSingleOrNull();
      await _database
          .into(_database.databaseMetadata)
          .insertOnConflictUpdate(
            database.DatabaseMetadataCompanion.insert(
              key: _holidayEnabledKey,
              value: enabled ? '1' : '0',
              createdAt: existing?.createdAt ?? now,
              updatedAt: now,
            ),
          );
      await _database.delete(_database.calendarDayCache).go();
      await _bumpInputVersion(now);
      await _writeAudit(
        entityType: 'holiday_setting',
        entityId: holidayRegion,
        changeType: enabled ? 'enable' : 'disable',
        before: existing?.value,
        after: enabled,
        now: now,
      );
    });
  }

  @override
  Future<String> loadInputVersion() async {
    final query = _database.select(_database.databaseMetadata)
      ..where((table) => table.key.equals(_inputVersionKey));
    return (await query.getSingleOrNull())?.value ?? '0';
  }

  @override
  Future<Map<LocalDate, ResolvedCalendarDay>> loadCachedDays({
    required DateRange range,
    required String inputVersion,
    required int resolverVersion,
  }) async {
    final query = _database.select(_database.calendarDayCache)
      ..where(
        (table) =>
            table.workDate.isBiggerOrEqualValue(range.start.toString()) &
            table.workDate.isSmallerOrEqualValue(range.end.toString()) &
            table.inputVersion.equals(inputVersion) &
            table.resolverVersion.equals(resolverVersion),
      );
    final rows = await query.get();
    return Map<LocalDate, ResolvedCalendarDay>.unmodifiable(
      <LocalDate, ResolvedCalendarDay>{
        for (final row in rows)
          LocalDate.parse(row.workDate): ResolvedCalendarDay(
            date: LocalDate.parse(row.workDate),
            status: _codec.decodeDayStatus(row.resolvedStatus),
            shift: row.shiftSnapshotJson == null
                ? null
                : _codec.decodeShiftSnapshot(row.shiftSnapshotJson!),
            source: DaySource.values.byName(row.sourceType),
            sourceId: row.sourceId,
            plannedPaidMinutes: row.plannedMinutes,
            tags: const <DayTag>[],
            resolverVersion: row.resolverVersion,
          ),
      },
    );
  }

  @override
  Future<void> replaceCachedDays({
    required List<ResolvedCalendarDay> days,
    required String inputVersion,
  }) async {
    if (days.isEmpty) {
      return;
    }
    final resolvedAt = _nowMillis;
    await _database.transaction(() async {
      await _database.batch((batch) {
        for (final day in days) {
          batch.insert(
            _database.calendarDayCache,
            database.CalendarDayCacheCompanion.insert(
              workDate: day.date.toString(),
              resolvedStatus: day.status.name,
              shiftSnapshotJson: Value<String?>(
                day.shift == null
                    ? null
                    : _codec.encodeShiftSnapshot(day.shift!),
              ),
              sourceType: day.source.name,
              sourceId: Value<String?>(day.sourceId),
              plannedMinutes: day.plannedPaidMinutes,
              resolverVersion: day.resolverVersion,
              inputVersion: inputVersion,
              resolvedAt: resolvedAt,
            ),
            mode: InsertMode.insertOrReplace,
          );
        }
      });
    });
  }

  @override
  Future<void> saveShift(ShiftSnapshot shift) async {
    final now = _nowMillis;
    await _database.transaction(() async {
      final query = _database.select(_database.shiftTemplates)
        ..where((table) => table.id.equals(shift.id.value));
      final existing = await query.getSingleOrNull();
      await _database
          .into(_database.shiftTemplates)
          .insertOnConflictUpdate(
            database.ShiftTemplatesCompanion.insert(
              id: shift.id.value,
              name: shift.name,
              shortName: shift.shortName,
              startMinute: Value<int?>(shift.startMinute),
              endMinute: Value<int?>(shift.endMinute),
              crossDay: shift.crossDay ? 1 : 0,
              unpaidBreakMinutes: shift.unpaidBreakMinutes,
              plannedPaidMinutes: Value<int?>(shift.plannedPaidMinutes),
              colorArgb: shift.colorArgb,
              isWorkday: shift.isWorkday ? 1 : 0,
              enabled: 1,
              createdAt: existing?.createdAt ?? now,
              updatedAt: now,
              deletedAt: const Value<int?>(null),
            ),
          );
      await _database.delete(_database.calendarDayCache).go();
      await _bumpInputVersion(now);
      await _writeAudit(
        entityType: 'shift_template',
        entityId: shift.id.value,
        changeType: existing == null ? 'create' : 'update',
        before: existing?.toJson(),
        after: jsonDecode(_codec.encodeShiftSnapshot(shift)),
        now: now,
      );
    });
  }

  @override
  Future<void> saveScheduleSetup({
    required ShiftSnapshot shift,
    required ScheduleRule rule,
  }) async {
    final encoded = _codec.encodeRule(rule);
    final now = _nowMillis;
    await _database.transaction(() async {
      final shiftQuery = _database.select(_database.shiftTemplates)
        ..where((table) => table.id.equals(shift.id.value));
      final existingShift = await shiftQuery.getSingleOrNull();
      await _database
          .into(_database.shiftTemplates)
          .insertOnConflictUpdate(
            database.ShiftTemplatesCompanion.insert(
              id: shift.id.value,
              name: shift.name,
              shortName: shift.shortName,
              startMinute: Value<int?>(shift.startMinute),
              endMinute: Value<int?>(shift.endMinute),
              crossDay: shift.crossDay ? 1 : 0,
              unpaidBreakMinutes: shift.unpaidBreakMinutes,
              plannedPaidMinutes: Value<int?>(shift.plannedPaidMinutes),
              colorArgb: shift.colorArgb,
              isWorkday: shift.isWorkday ? 1 : 0,
              enabled: 1,
              createdAt: existingShift?.createdAt ?? now,
              updatedAt: now,
              deletedAt: const Value<int?>(null),
            ),
          );

      final ruleQuery = _database.select(_database.scheduleRules)
        ..where((table) => table.id.equals(rule.id.value));
      final existingRule = await ruleQuery.getSingleOrNull();
      await _database
          .into(_database.scheduleRules)
          .insertOnConflictUpdate(
            database.ScheduleRulesCompanion.insert(
              id: rule.id.value,
              name: rule.name,
              ruleType: encoded.ruleType,
              anchorDate: encoded.anchorDate.toString(),
              cycleLengthDays: Value<int?>(encoded.cycleLengthDays),
              cyclePayloadJson: encoded.payloadJson,
              effectiveStart: rule.effectiveRange.start.toString(),
              effectiveEnd: Value<String?>(
                rule.effectiveRange.end == LocalDate(9999, 12, 31)
                    ? null
                    : rule.effectiveRange.end.toString(),
              ),
              priority: rule.priority,
              enabled: 1,
              createdAt: existingRule?.createdAt ?? now,
              updatedAt: now,
              deletedAt: const Value<int?>(null),
            ),
          );

      await _database.delete(_database.calendarDayCache).go();
      await _bumpInputVersion(now);
      await _writeAudit(
        entityType: 'shift_template',
        entityId: shift.id.value,
        changeType: existingShift == null ? 'create' : 'update',
        before: existingShift?.toJson(),
        after: (await shiftQuery.getSingle()).toJson(),
        now: now,
      );
      await _writeAudit(
        entityType: 'schedule_rule',
        entityId: rule.id.value,
        changeType: existingRule == null ? 'create' : 'update',
        before: existingRule?.toJson(),
        after: (await ruleQuery.getSingle()).toJson(),
        now: now,
      );
    });
  }

  @override
  Future<void> setShiftEnabled(ShiftId id, {required bool enabled}) async {
    final now = _nowMillis;
    await _database.transaction(() async {
      final query = _database.select(
        _database.shiftTemplates,
      )..where((table) => table.id.equals(id.value) & table.deletedAt.isNull());
      final existing = await query.getSingleOrNull();
      if (existing == null) {
        throw StateError('Shift template ${id.value} does not exist.');
      }
      if (!enabled) {
        final rules = await loadStoredRules();
        if (rules.any(
          (stored) => stored.enabled && _ruleReferencesShift(stored.rule, id),
        )) {
          throw StateError(
            'Shift template ${id.value} is referenced by an active rule.',
          );
        }
      }
      await (_database.update(
        _database.shiftTemplates,
      )..where((table) => table.id.equals(id.value))).write(
        database.ShiftTemplatesCompanion(
          enabled: Value<int>(enabled ? 1 : 0),
          updatedAt: Value<int>(now),
        ),
      );
      await _database.delete(_database.calendarDayCache).go();
      await _bumpInputVersion(now);
      await _writeAudit(
        entityType: 'shift_template',
        entityId: id.value,
        changeType: enabled ? 'enable' : 'disable',
        before: existing.toJson(),
        after: (await query.getSingle()).toJson(),
        now: now,
      );
    });
  }

  @override
  Future<void> saveRule(ScheduleRule rule, {required bool enabled}) async {
    final encoded = _codec.encodeRule(rule);
    final now = _nowMillis;
    await _database.transaction(() async {
      final query = _database.select(_database.scheduleRules)
        ..where((table) => table.id.equals(rule.id.value));
      final existing = await query.getSingleOrNull();
      await _database
          .into(_database.scheduleRules)
          .insertOnConflictUpdate(
            database.ScheduleRulesCompanion.insert(
              id: rule.id.value,
              name: rule.name,
              ruleType: encoded.ruleType,
              anchorDate: encoded.anchorDate.toString(),
              cycleLengthDays: Value<int?>(encoded.cycleLengthDays),
              cyclePayloadJson: encoded.payloadJson,
              effectiveStart: rule.effectiveRange.start.toString(),
              effectiveEnd: Value<String?>(
                rule.effectiveRange.end == LocalDate(9999, 12, 31)
                    ? null
                    : rule.effectiveRange.end.toString(),
              ),
              priority: rule.priority,
              enabled: enabled ? 1 : 0,
              createdAt: existing?.createdAt ?? now,
              updatedAt: now,
              deletedAt: const Value<int?>(null),
            ),
          );
      await _invalidateRange(rule.effectiveRange);
      await _bumpInputVersion(now);
      final saved = await query.getSingle();
      await _writeAudit(
        entityType: 'schedule_rule',
        entityId: rule.id.value,
        changeType: existing == null ? 'create' : 'update',
        before: existing?.toJson(),
        after: saved.toJson(),
        now: now,
      );
    });
  }

  @override
  Future<void> setRuleEnabled(RuleId id, {required bool enabled}) async {
    final now = _nowMillis;
    await _database.transaction(() async {
      final query = _database.select(
        _database.scheduleRules,
      )..where((table) => table.id.equals(id.value) & table.deletedAt.isNull());
      final existing = await query.getSingleOrNull();
      if (existing == null) {
        throw StateError('Schedule rule ${id.value} does not exist.');
      }
      await (_database.update(
        _database.scheduleRules,
      )..where((table) => table.id.equals(id.value))).write(
        database.ScheduleRulesCompanion(
          enabled: Value<int>(enabled ? 1 : 0),
          updatedAt: Value<int>(now),
        ),
      );
      await _invalidateRange(
        DateRange(
          start: LocalDate.parse(existing.effectiveStart),
          end: LocalDate.parse(existing.effectiveEnd ?? '9999-12-31'),
        ),
      );
      await _bumpInputVersion(now);
      final saved = await query.getSingle();
      await _writeAudit(
        entityType: 'schedule_rule',
        entityId: id.value,
        changeType: enabled ? 'enable' : 'disable',
        before: existing.toJson(),
        after: saved.toJson(),
        now: now,
      );
    });
  }

  @override
  Future<void> saveOverrides(
    List<CalendarOverride> overrides, {
    required DaySource source,
  }) async {
    if (overrides.isEmpty) {
      return;
    }
    final overrideType = _overrideType(source);
    final now = _nowMillis;
    await _database.transaction(() async {
      for (final override in overrides) {
        final activeQuery = _database.select(_database.dayOverrides)
          ..where(
            (table) =>
                table.workDate.equals(override.date.toString()) &
                table.deletedAt.isNull(),
          );
        final active = await activeQuery.getSingleOrNull();
        if (active != null && active.id != override.id) {
          await (_database.update(
            _database.dayOverrides,
          )..where((table) => table.id.equals(active.id))).write(
            database.DayOverridesCompanion(
              deletedAt: Value<int?>(now),
              updatedAt: Value<int>(now),
            ),
          );
        }

        final sameIdQuery = _database.select(_database.dayOverrides)
          ..where((table) => table.id.equals(override.id));
        final sameId = await sameIdQuery.getSingleOrNull();
        await _database
            .into(_database.dayOverrides)
            .insertOnConflictUpdate(
              database.DayOverridesCompanion.insert(
                id: override.id,
                workDate: override.date.toString(),
                status: override.status.name,
                shiftTemplateId: Value<String?>(override.shift?.id.value),
                shiftSnapshotJson: Value<String?>(
                  override.shift == null
                      ? null
                      : _codec.encodeShiftSnapshot(override.shift!),
                ),
                overrideType: overrideType,
                createdAt: sameId?.createdAt ?? now,
                updatedAt: now,
                deletedAt: const Value<int?>(null),
              ),
            );
        final saved = await sameIdQuery.getSingle();
        await _writeAudit(
          entityType: 'day_override',
          entityId: override.id,
          changeType: active == null ? 'create' : 'replace',
          before: active?.toJson(),
          after: saved.toJson(),
          now: now,
        );
      }
      final dates = overrides.map((item) => item.date).toList()..sort();
      await _invalidateRange(DateRange(start: dates.first, end: dates.last));
      await _bumpInputVersion(now);
    });
  }

  @override
  Future<void> restoreOverrides(
    DateRange range, {
    required DaySource source,
  }) async {
    final overrideType = _overrideType(source);
    final now = _nowMillis;
    await _database.transaction(() async {
      final query = _database.select(_database.dayOverrides)
        ..where(
          (table) =>
              table.overrideType.equals(overrideType) &
              table.deletedAt.isNull() &
              table.workDate.isBiggerOrEqualValue(range.start.toString()) &
              table.workDate.isSmallerOrEqualValue(range.end.toString()),
        );
      final active = await query.get();
      if (active.isEmpty) {
        return;
      }
      await (_database.update(_database.dayOverrides)..where(
            (table) =>
                table.overrideType.equals(overrideType) &
                table.deletedAt.isNull() &
                table.workDate.isBiggerOrEqualValue(range.start.toString()) &
                table.workDate.isSmallerOrEqualValue(range.end.toString()),
          ))
          .write(
            database.DayOverridesCompanion(
              deletedAt: Value<int?>(now),
              updatedAt: Value<int>(now),
            ),
          );
      for (final row in active) {
        await _writeAudit(
          entityType: 'day_override',
          entityId: row.id,
          changeType: 'restore_rule_result',
          before: row.toJson(),
          after: null,
          now: now,
        );
      }
      await _invalidateRange(range);
      await _bumpInputVersion(now);
    });
  }

  @override
  Future<HolidayUpdateSummary> replaceOfficialHolidays({
    required String region,
    required String dataVersion,
    required List<HolidayImportRecord> holidays,
    required int updatedAt,
  }) async {
    final query = _database.select(_database.holidayRecords)
      ..where((table) => table.region.equals(region));
    final existing = await query.get();
    final before = <String, database.HolidayRecord>{
      for (final row in existing) row.workDate: row,
    };
    final next = <String, HolidayImportRecord>{
      for (final holiday in holidays) holiday.date.toString(): holiday,
    };
    if (next.length != holidays.length) {
      throw ArgumentError('Holiday dataset contains duplicate dates.');
    }
    final added = next.keys.where((date) => !before.containsKey(date)).length;
    final removed = before.keys.where((date) => !next.containsKey(date)).length;
    final changed = next.entries.where((entry) {
      final previous = before[entry.key];
      return previous != null &&
          (previous.name != entry.value.name ||
              previous.dayType != _holidayDayType(entry.value.status));
    }).length;
    final now = _nowMillis;

    await _database.transaction(() async {
      await (_database.delete(
        _database.holidayRecords,
      )..where((table) => table.region.equals(region))).go();
      await _database.batch((batch) {
        for (final holiday in holidays) {
          batch.insert(
            _database.holidayRecords,
            database.HolidayRecordsCompanion.insert(
              workDate: holiday.date.toString(),
              region: region,
              name: holiday.name,
              dayType: _holidayDayType(holiday.status),
              dataVersion: dataVersion,
              publishedAt: Value<int?>(holiday.publishedAt),
              updatedAt: updatedAt,
            ),
          );
        }
      });
      await _database.delete(_database.calendarDayCache).go();
      await _bumpInputVersion(now);
      await _writeAudit(
        entityType: 'holiday_dataset',
        entityId: region,
        changeType: 'replace',
        before: existing.map((row) => row.toJson()).toList(growable: false),
        after: <String, Object?>{
          'dataVersion': dataVersion,
          'records': holidays
              .map(
                (holiday) => <String, Object?>{
                  'date': holiday.date.toString(),
                  'name': holiday.name,
                  'status': holiday.status.name,
                  'publishedAt': holiday.publishedAt,
                },
              )
              .toList(growable: false),
        },
        now: now,
      );
    });
    return HolidayUpdateSummary(
      added: added,
      removed: removed,
      changed: changed,
    );
  }

  Future<Map<LocalDate, CalendarOverride>> _loadOverrides(
    DateRange range,
    String type,
  ) async {
    final shifts = await _loadShiftMap();
    final query = _database.select(_database.dayOverrides)
      ..where(
        (table) =>
            table.overrideType.equals(type) &
            table.deletedAt.isNull() &
            table.workDate.isBiggerOrEqualValue(range.start.toString()) &
            table.workDate.isSmallerOrEqualValue(range.end.toString()),
      );
    final rows = await query.get();
    return Map<LocalDate, CalendarOverride>.unmodifiable(
      <LocalDate, CalendarOverride>{
        for (final row in rows)
          LocalDate.parse(row.workDate): CalendarOverride(
            id: row.id,
            date: LocalDate.parse(row.workDate),
            status: _codec.decodeDayStatus(row.status),
            shift: _resolveOverrideShift(row, shifts),
          ),
      },
    );
  }

  Future<List<database.ShiftTemplate>> _loadWorkShiftRows({
    required bool onlyEnabled,
  }) {
    final query = _database.select(_database.shiftTemplates)
      ..where(
        (table) =>
            table.isWorkday.equals(1) &
            table.deletedAt.isNull() &
            (onlyEnabled ? table.enabled.equals(1) : const Constant(true)),
      );
    return query.get();
  }

  Future<Map<String, ShiftSnapshot>> _loadShiftMap() async {
    final rows = await _loadWorkShiftRows(onlyEnabled: false);
    return <String, ShiftSnapshot>{
      for (final row in rows) row.id: _mapShift(row),
    };
  }

  ShiftSnapshot _mapShift(database.ShiftTemplate row) {
    final startMinute = row.startMinute;
    final endMinute = row.endMinute;
    final plannedPaidMinutes = row.plannedPaidMinutes;
    if (startMinute == null ||
        endMinute == null ||
        plannedPaidMinutes == null) {
      throw StateError('Work shift ${row.id} has incomplete time data.');
    }
    return ShiftSnapshot(
      id: ShiftId(row.id),
      name: row.name,
      shortName: row.shortName,
      startMinute: startMinute,
      endMinute: endMinute,
      crossDay: row.crossDay == 1,
      unpaidBreakMinutes: row.unpaidBreakMinutes,
      plannedPaidMinutes: plannedPaidMinutes,
      colorArgb: row.colorArgb,
      isWorkday: row.isWorkday == 1,
    );
  }

  ShiftSnapshot? _resolveOverrideShift(
    database.DayOverride row,
    Map<String, ShiftSnapshot> shifts,
  ) {
    final snapshot = row.shiftSnapshotJson;
    if (snapshot != null) {
      return _codec.decodeShiftSnapshot(snapshot);
    }
    final shiftId = row.shiftTemplateId;
    return shiftId == null ? null : shifts[shiftId];
  }

  Future<void> _invalidateRange(DateRange range) {
    return (_database.delete(_database.calendarDayCache)..where(
          (table) =>
              table.workDate.isBiggerOrEqualValue(range.start.toString()) &
              table.workDate.isSmallerOrEqualValue(range.end.toString()),
        ))
        .go();
  }

  Future<void> _bumpInputVersion(int now) async {
    final query = _database.select(_database.databaseMetadata)
      ..where((table) => table.key.equals(_inputVersionKey));
    final existing = await query.getSingleOrNull();
    final current = int.tryParse(existing?.value ?? '0') ?? 0;
    await _database
        .into(_database.databaseMetadata)
        .insertOnConflictUpdate(
          database.DatabaseMetadataCompanion.insert(
            key: _inputVersionKey,
            value: '${current + 1}',
            createdAt: existing?.createdAt ?? now,
            updatedAt: now,
          ),
        );
  }

  Future<void> _writeAudit({
    required String entityType,
    required String entityId,
    required String changeType,
    required Object? before,
    required Object? after,
    required int now,
  }) {
    return _database
        .into(_database.changeLog)
        .insert(
          database.ChangeLogCompanion.insert(
            id: _idGenerator.generate(),
            entityType: entityType,
            entityId: entityId,
            changeType: changeType,
            beforeSnapshotJson: Value<String?>(
              before == null ? null : jsonEncode(before),
            ),
            afterSnapshotJson: Value<String?>(
              after == null ? null : jsonEncode(after),
            ),
            createdAt: now,
            updatedAt: now,
          ),
        );
  }

  String _overrideType(DaySource source) {
    return switch (source) {
      DaySource.userOverride => 'user',
      DaySource.companyOverride => 'company',
      _ => throw ArgumentError.value(
        source,
        'source',
        'Only user and company override sources are writable.',
      ),
    };
  }

  DayStatus _decodeHolidayStatus(String value) {
    return switch (value) {
      'holiday' => DayStatus.publicHoliday,
      'adjusted_workday' => DayStatus.adjustedWorkday,
      _ => throw FormatException('Unsupported holiday day type: $value'),
    };
  }

  String _holidayDayType(DayStatus status) {
    return switch (status) {
      DayStatus.publicHoliday => 'holiday',
      DayStatus.adjustedWorkday => 'adjusted_workday',
      _ => throw ArgumentError.value(status, 'status'),
    };
  }

  bool _ruleReferencesShift(ScheduleRule rule, ShiftId id) {
    if (rule is WeeklyScheduleRule) {
      return _weekReferencesShift(rule.week, id);
    }
    if (rule is CycleScheduleRule) {
      return rule.cycle.any((day) => day.shift?.id == id);
    }
    if (rule is AlternatingWeekScheduleRule) {
      return _weekReferencesShift(rule.anchorWeek, id) ||
          _weekReferencesShift(rule.alternateWeek, id);
    }
    return false;
  }

  bool _weekReferencesShift(WeekTemplate week, ShiftId id) {
    for (var weekday = DateTime.monday; weekday <= DateTime.sunday; weekday++) {
      if (week.forWeekday(weekday).shift?.id == id) {
        return true;
      }
    }
    return false;
  }

  int get _nowMillis => _clock.nowUtc().millisecondsSinceEpoch;
}
