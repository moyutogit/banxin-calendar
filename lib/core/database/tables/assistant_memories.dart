import 'package:drift/drift.dart';

class AssistantMemories extends Table {
  @override
  String get tableName => 'assistant_memories';

  TextColumn get id => text()();
  TextColumn get content => text()();
  TextColumn get category => text()();
  TextColumn get sourceConversationId => text().nullable()();
  IntColumn get createdAt => integer()();
  IntColumn get updatedAt => integer()();
  IntColumn get deletedAt => integer().nullable()();

  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{id};
}
