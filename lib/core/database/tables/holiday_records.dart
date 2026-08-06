import 'package:drift/drift.dart';

class HolidayRecords extends Table {
  @override
  String get tableName => 'holiday_records';

  TextColumn get workDate => text()();
  TextColumn get region => text()();
  TextColumn get name => text()();
  TextColumn get dayType => text()();
  TextColumn get dataVersion => text()();
  IntColumn get publishedAt => integer().nullable()();
  IntColumn get updatedAt => integer()();

  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{workDate, region};
}
