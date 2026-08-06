import 'package:drift/drift.dart';

class CalendarDayCache extends Table {
  @override
  String get tableName => 'calendar_day_cache';

  TextColumn get workDate => text()();
  TextColumn get resolvedStatus => text()();
  TextColumn get shiftSnapshotJson => text().nullable()();
  TextColumn get sourceType => text()();
  TextColumn get sourceId => text().nullable()();
  IntColumn get plannedMinutes => integer()();
  IntColumn get resolverVersion => integer()();
  TextColumn get inputVersion => text()();
  IntColumn get resolvedAt => integer()();

  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{workDate};
}
