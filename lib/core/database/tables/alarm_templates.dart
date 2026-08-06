import 'package:drift/drift.dart';

class AlarmTemplates extends Table {
  @override
  String get tableName => 'alarm_templates';

  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get mode => text()();
  IntColumn get fixedMinute => integer().nullable()();
  IntColumn get offsetMinutes => integer().nullable()();
  TextColumn get soundId => text().nullable()();
  IntColumn get vibrate => integer()();
  IntColumn get volumeRamp => integer().withDefault(const Constant<int>(0))();
  IntColumn get snoozeMinutes => integer()();
  IntColumn get maxSnoozeCount => integer()();
  IntColumn get enabled => integer()();
  IntColumn get createdAt => integer()();
  IntColumn get updatedAt => integer()();
  IntColumn get deletedAt => integer().nullable()();

  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{id};
}
