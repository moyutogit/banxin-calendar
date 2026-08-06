import 'package:banxin_calendar/features/attendance/domain/attendance_entities.dart';
import 'package:banxin_calendar/features/schedule/domain/value_objects.dart';

abstract interface class AttendanceRepository {
  Future<List<AttendanceSegment>> loadSegments(DateRange range);

  Future<void> saveSegment(AttendanceSegment segment);

  Future<void> deleteSegment(String id);

  Future<bool> hasSettledPayroll(LocalDate workDate);
}
