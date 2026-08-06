import 'package:banxin_calendar/core/database/app_database.dart' as database;
import 'package:banxin_calendar/core/time/app_clock.dart';
import 'package:banxin_calendar/features/attendance/domain/attendance_engine.dart';
import 'package:banxin_calendar/features/attendance/domain/attendance_entities.dart';
import 'package:banxin_calendar/features/attendance/domain/attendance_repository.dart';
import 'package:banxin_calendar/features/schedule/domain/value_objects.dart';
import 'package:drift/drift.dart';

final class DriftAttendanceRepository implements AttendanceRepository {
  const DriftAttendanceRepository(
    this._database, {
    this._clock = const SystemAppClock(),
    this._engine = const AttendanceEngine(),
  });

  final database.AppDatabase _database;
  final AppClock _clock;
  final AttendanceEngine _engine;

  int get _now => _clock.nowUtc().millisecondsSinceEpoch;

  @override
  Future<List<AttendanceSegment>> loadSegments(DateRange range) async {
    final rows =
        await (_database.select(_database.attendanceRecords)
              ..where(
                (table) =>
                    table.workDate.isBiggerOrEqualValue(
                      range.start.toString(),
                    ) &
                    table.workDate.isSmallerOrEqualValue(range.end.toString()) &
                    table.deletedAt.isNull(),
              )
              ..orderBy(
                <OrderingTerm Function(database.$AttendanceRecordsTable)>[
                  (table) => OrderingTerm.asc(table.clockInAt),
                ],
              ))
            .get();
    return List<AttendanceSegment>.unmodifiable(rows.map(_map));
  }

  @override
  Future<void> saveSegment(AttendanceSegment segment) async {
    final dayRange = DateRange(start: segment.workDate, end: segment.workDate);
    final existingForDay = await loadSegments(dayRange);
    _engine.calculate(
      segments: <AttendanceSegment>[
        ...existingForDay.where((existing) => existing.id != segment.id),
        segment,
      ],
      policy: const WorkTimePolicy(),
    );
    final now = _now;
    final existing = await (_database.select(
      _database.attendanceRecords,
    )..where((table) => table.id.equals(segment.id))).getSingleOrNull();
    await _database
        .into(_database.attendanceRecords)
        .insertOnConflictUpdate(
          database.AttendanceRecordsCompanion.insert(
            id: segment.id,
            workDate: segment.workDate.toString(),
            clockInAt: Value<int?>(segment.clockInUtc?.millisecondsSinceEpoch),
            clockOutAt: Value<int?>(
              segment.clockOutUtc?.millisecondsSinceEpoch,
            ),
            unpaidBreakMinutes: segment.unpaidBreakMinutes,
            source: segment.source.name,
            status: segment.status.name,
            editReason: Value<String?>(segment.editReason?.name),
            note: Value<String?>(segment.note),
            createdTimezone: segment.createdTimezone,
            confirmed: Value<int>(segment.confirmed ? 1 : 0),
            createdAt: existing?.createdAt ?? now,
            updatedAt: now,
            deletedAt: const Value<int?>(null),
          ),
        );
  }

  @override
  Future<void> deleteSegment(String id) async {
    final changed =
        await (_database.update(
              _database.attendanceRecords,
            )..where((table) => table.id.equals(id) & table.deletedAt.isNull()))
            .write(
              database.AttendanceRecordsCompanion(
                deletedAt: Value<int?>(_now),
                updatedAt: Value<int>(_now),
              ),
            );
    if (changed != 1) throw StateError('Attendance record $id not found.');
  }

  @override
  Future<bool> hasSettledPayroll(LocalDate workDate) async {
    final row =
        await (_database.select(_database.payrollPeriods)..where(
              (table) =>
                  table.startDate.isSmallerOrEqualValue(workDate.toString()) &
                  table.endDate.isBiggerOrEqualValue(workDate.toString()) &
                  table.status.equals('settled'),
            ))
            .getSingleOrNull();
    return row != null;
  }

  AttendanceSegment _map(database.AttendanceRecord row) => AttendanceSegment(
    id: row.id,
    workDate: LocalDate.parse(row.workDate),
    clockInUtc: row.clockInAt == null
        ? null
        : DateTime.fromMillisecondsSinceEpoch(row.clockInAt!, isUtc: true),
    clockOutUtc: row.clockOutAt == null
        ? null
        : DateTime.fromMillisecondsSinceEpoch(row.clockOutAt!, isUtc: true),
    unpaidBreakMinutes: row.unpaidBreakMinutes,
    source: AttendanceSource.values.byName(row.source),
    status: AttendanceRecordStatus.values.byName(row.status),
    editReason: row.editReason == null
        ? null
        : AttendanceEditReason.values.byName(row.editReason!),
    note: row.note,
    createdTimezone: row.createdTimezone,
    confirmed: row.confirmed == 1,
  );
}
