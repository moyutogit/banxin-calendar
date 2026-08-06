import 'package:drift/drift.dart';

class ScheduleRules extends Table {
  @override
  String get tableName => 'schedule_rules';

  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get ruleType => text()();
  TextColumn get anchorDate => text()();
  IntColumn get cycleLengthDays => integer().nullable()();
  TextColumn get cyclePayloadJson => text()();
  TextColumn get effectiveStart => text()();
  TextColumn get effectiveEnd => text().nullable()();
  IntColumn get priority => integer()();
  IntColumn get enabled => integer()();
  IntColumn get createdAt => integer()();
  IntColumn get updatedAt => integer()();
  IntColumn get deletedAt => integer().nullable()();

  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{id};
}
