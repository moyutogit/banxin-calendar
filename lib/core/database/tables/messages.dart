import 'package:banxin_calendar/core/database/tables/conversations.dart';
import 'package:drift/drift.dart';

class Messages extends Table {
  @override
  String get tableName => 'messages';

  TextColumn get id => text()();
  TextColumn get conversationId => text().references(Conversations, #id)();
  TextColumn get role => text()();
  TextColumn get content => text()();
  TextColumn get reasoningContent => text().nullable()();
  TextColumn get contentType => text()();
  TextColumn get toolCallId => text().nullable()();
  IntColumn get localOnly => integer()();
  IntColumn get createdAt => integer()();

  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{id};
}
