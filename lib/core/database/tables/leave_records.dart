import 'package:drift/drift.dart';

class LeaveRecords extends Table {
  @override
  String get tableName => 'leave_records';

  TextColumn get id => text()();
  TextColumn get workDate => text()();
  TextColumn get leaveType => text()();
  IntColumn get startAt => integer().nullable()();
  IntColumn get endAt => integer().nullable()();
  IntColumn get paid => integer()();
  IntColumn get deductionMinor => integer().nullable()();
  TextColumn get note => text().nullable()();
  IntColumn get createdAt => integer()();
  IntColumn get updatedAt => integer()();
  IntColumn get deletedAt => integer().nullable()();

  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{id};
}
