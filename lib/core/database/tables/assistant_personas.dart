import 'package:drift/drift.dart';

class AssistantPersonas extends Table {
  @override
  String get tableName => 'assistant_personas';

  TextColumn get id => text()();
  TextColumn get displayName => text()();
  TextColumn get presetType => text()();
  TextColumn get customInstruction => text().nullable()();
  TextColumn get replyLength => text()();
  IntColumn get initiativeLevel => integer()();
  IntColumn get emojiLevel => integer()();
  TextColumn get avatarAssetId => text()();
  IntColumn get scheduleRead => integer()();
  IntColumn get attendanceRead => integer()();
  IntColumn get wageRead => integer()();
  IntColumn get alarmRead => integer()();
  IntColumn get notesRead => integer()();
  IntColumn get updatedAt => integer()();

  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{id};
}
