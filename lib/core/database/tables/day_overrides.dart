import 'package:banxin_calendar/core/database/tables/shift_templates.dart';
import 'package:drift/drift.dart';

class DayOverrides extends Table {
  @override
  String get tableName => 'day_overrides';

  TextColumn get id => text()();
  TextColumn get workDate => text()();
  TextColumn get status => text()();
  TextColumn get shiftTemplateId => text().nullable().references(
    ShiftTemplates,
    #id,
    onDelete: KeyAction.restrict,
  )();
  TextColumn get shiftSnapshotJson => text().nullable()();
  TextColumn get overrideType => text()();
  TextColumn get reason => text().nullable()();
  TextColumn get note => text().nullable()();
  IntColumn get createdAt => integer()();
  IntColumn get updatedAt => integer()();
  IntColumn get deletedAt => integer().nullable()();

  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{id};
}
