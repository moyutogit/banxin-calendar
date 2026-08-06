import 'package:banxin_calendar/core/ids/stable_id_generator.dart';
import 'package:banxin_calendar/core/time/app_clock.dart';
import 'package:banxin_calendar/features/attendance/domain/attendance_engine.dart';
import 'package:banxin_calendar/features/attendance/domain/attendance_entities.dart';
import 'package:banxin_calendar/features/attendance/domain/attendance_repository.dart';
import 'package:banxin_calendar/features/schedule/domain/value_objects.dart';

final class AttendanceDayView {
  const AttendanceDayView({
    required this.date,
    required this.segments,
    required this.hours,
    required this.hasOpenPunch,
  });

  final LocalDate date;
  final List<AttendanceSegment> segments;
  final DailyHours hours;
  final bool hasOpenPunch;
}

final class AttendanceMutationResult {
  const AttendanceMutationResult({
    required this.segment,
    required this.requiresPayrollRecalculation,
  });

  final AttendanceSegment segment;
  final bool requiresPayrollRecalculation;
}

final class AttendanceApplicationService {
  AttendanceApplicationService(
    this._repository, {
    this._engine = const AttendanceEngine(),
    this._clock = const SystemAppClock(),
    StableIdGenerator? idGenerator,
  }) : _idGenerator = idGenerator ?? UuidV4Generator();

  final AttendanceRepository _repository;
  final AttendanceEngine _engine;
  final AppClock _clock;
  final StableIdGenerator _idGenerator;

  Future<AttendanceDayView> loadDay(
    LocalDate date, {
    WorkTimePolicy policy = const WorkTimePolicy(),
  }) async {
    final segments = await _repository.loadSegments(
      DateRange(start: date, end: date),
    );
    return AttendanceDayView(
      date: date,
      segments: segments,
      hours: _engine.calculate(segments: segments, policy: policy),
      hasOpenPunch: segments.any(
        (segment) => segment.clockInUtc != null && segment.clockOutUtc == null,
      ),
    );
  }

  Future<AttendanceMutationResult> punch(LocalDate workDate) async {
    final view = await loadDay(workDate);
    final now = _clock.nowUtc();
    final open = view.segments
        .where(
          (segment) =>
              segment.clockInUtc != null && segment.clockOutUtc == null,
        )
        .firstOrNull;
    final segment = open == null
        ? AttendanceSegment(
            id: _idGenerator.generate(),
            workDate: workDate,
            clockInUtc: now,
            clockOutUtc: null,
            unpaidBreakMinutes: 0,
            source: AttendanceSource.punch,
            status: AttendanceRecordStatus.incomplete,
            createdTimezone: now.toLocal().timeZoneName,
            confirmed: false,
          )
        : AttendanceSegment(
            id: open.id,
            workDate: open.workDate,
            clockInUtc: open.clockInUtc,
            clockOutUtc: now,
            unpaidBreakMinutes: open.unpaidBreakMinutes,
            source: open.source,
            status: AttendanceRecordStatus.complete,
            editReason: open.editReason,
            note: open.note,
            createdTimezone: open.createdTimezone,
            confirmed: open.confirmed,
          );
    await _repository.saveSegment(segment);
    return AttendanceMutationResult(
      segment: segment,
      requiresPayrollRecalculation: await _repository.hasSettledPayroll(
        workDate,
      ),
    );
  }

  Future<AttendanceMutationResult> saveManual({
    String? id,
    required LocalDate workDate,
    required DateTime? clockInUtc,
    required DateTime? clockOutUtc,
    required int unpaidBreakMinutes,
    required AttendanceEditReason editReason,
    required String? note,
    required bool confirmed,
  }) async {
    final complete = clockInUtc != null && clockOutUtc != null;
    final segment = AttendanceSegment(
      id: id ?? _idGenerator.generate(),
      workDate: workDate,
      clockInUtc: clockInUtc,
      clockOutUtc: clockOutUtc,
      unpaidBreakMinutes: unpaidBreakMinutes,
      source: AttendanceSource.manual,
      status: complete
          ? AttendanceRecordStatus.complete
          : AttendanceRecordStatus.incomplete,
      editReason: editReason,
      note: note,
      createdTimezone: _clock.nowUtc().toLocal().timeZoneName,
      confirmed: confirmed,
    );
    await _repository.saveSegment(segment);
    return AttendanceMutationResult(
      segment: segment,
      requiresPayrollRecalculation: await _repository.hasSettledPayroll(
        workDate,
      ),
    );
  }

  Future<bool> delete(String id, LocalDate workDate) async {
    await _repository.deleteSegment(id);
    return _repository.hasSettledPayroll(workDate);
  }
}
