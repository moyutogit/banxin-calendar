import 'package:drift/drift.dart';

class ShiftTemplates extends Table {
  @override
  String get tableName => 'shift_templates';

  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get shortName => text()();
  IntColumn get startMinute => integer().nullable()();
  IntColumn get endMinute => integer().nullable()();
  IntColumn get crossDay => integer()();
  IntColumn get unpaidBreakMinutes => integer()();
  IntColumn get plannedPaidMinutes => integer().nullable()();
  IntColumn get colorArgb => integer()();
  IntColumn get isWorkday => integer()();
  IntColumn get enabled => integer()();
  IntColumn get createdAt => integer()();
  IntColumn get updatedAt => integer()();
  IntColumn get deletedAt => integer().nullable()();

  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{id};
}
