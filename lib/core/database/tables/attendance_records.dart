import 'package:drift/drift.dart';

class AttendanceRecords extends Table {
  @override
  String get tableName => 'attendance_records';

  TextColumn get id => text()();
  TextColumn get workDate => text()();
  IntColumn get clockInAt => integer().nullable()();
  IntColumn get clockOutAt => integer().nullable()();
  IntColumn get unpaidBreakMinutes => integer()();
  TextColumn get source => text()();
  TextColumn get status => text()();
  TextColumn get editReason => text().nullable()();
  TextColumn get note => text().nullable()();
  TextColumn get createdTimezone => text()();
  IntColumn get confirmed => integer().withDefault(const Constant<int>(0))();
  IntColumn get createdAt => integer()();
  IntColumn get updatedAt => integer()();
  IntColumn get deletedAt => integer().nullable()();

  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{id};
}
