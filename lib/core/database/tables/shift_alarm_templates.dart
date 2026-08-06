import 'package:banxin_calendar/core/database/tables/alarm_templates.dart';
import 'package:banxin_calendar/core/database/tables/shift_templates.dart';
import 'package:drift/drift.dart';

class ShiftAlarmTemplates extends Table {
  @override
  String get tableName => 'shift_alarm_templates';

  TextColumn get id => text()();
  TextColumn get shiftTemplateId => text().references(ShiftTemplates, #id)();
  TextColumn get alarmTemplateId => text().references(AlarmTemplates, #id)();
  IntColumn get createdAt => integer()();
  IntColumn get updatedAt => integer()();
  IntColumn get deletedAt => integer().nullable()();

  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{id};
}
