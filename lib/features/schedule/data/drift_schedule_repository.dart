import 'package:banxin_calendar/core/database/app_database.dart' as database;
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
  });

  final database.AppDatabase _database;
  final String holidayRegion;
  final ScheduleJsonCodec _codec;

  @override
  Future<List<ShiftSnapshot>> loadEnabledShifts() async {
    final query = _database.select(_database.shiftTemplates)
      ..where(
        (table) =>
            table.enabled.equals(1) &
            table.isWorkday.equals(1) &
            table.deletedAt.isNull(),
      );
    final rows = await query.get();
    return List<ShiftSnapshot>.unmodifiable(rows.map(_mapShift));
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
            status: switch (row.dayType) {
              'holiday' => DayStatus.publicHoliday,
              'adjusted_workday' => DayStatus.adjustedWorkday,
              _ => throw FormatException(
                'Unsupported holiday day type: ${row.dayType}',
              ),
            },
          ),
      },
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
            status: _decodeStatus(row.status),
            shift: _resolveOverrideShift(row, shifts),
          ),
      },
    );
  }

  Future<Map<String, ShiftSnapshot>> _loadShiftMap() async {
    final shifts = await loadEnabledShifts();
    return <String, ShiftSnapshot>{
      for (final shift in shifts) shift.id.value: shift,
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
      isWorkday: true,
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

  DayStatus _decodeStatus(String value) {
    try {
      return DayStatus.values.byName(value);
    } on ArgumentError {
      throw FormatException('Unsupported day status: $value');
    }
  }
}
