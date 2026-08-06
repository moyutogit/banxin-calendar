import 'package:banxin_calendar/core/database/tables/alarm_templates.dart';
import 'package:drift/drift.dart';

class AlarmInstances extends Table {
  @override
  String get tableName => 'alarm_instances';

  TextColumn get id => text()();
  TextColumn get templateId => text().references(AlarmTemplates, #id)();
  TextColumn get scheduleDate => text()();
  IntColumn get triggerAt => integer()();
  TextColumn get shiftId => text().nullable()();
  IntColumn get locked => integer()();
  TextColumn get platformAlarmId => text().unique()();
  TextColumn get status => text()();
  TextColumn get payloadHash => text()();
  TextColumn get errorCode => text().nullable()();
  IntColumn get retryCount => integer().withDefault(const Constant<int>(0))();
  IntColumn get nextRetryAt => integer().nullable()();
  IntColumn get lastSyncedAt => integer().nullable()();
  IntColumn get createdAt => integer()();
  IntColumn get updatedAt => integer()();

  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{id};
}
