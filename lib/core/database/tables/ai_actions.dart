import 'package:banxin_calendar/core/database/tables/conversations.dart';
import 'package:drift/drift.dart';

class AiActions extends Table {
  @override
  String get tableName => 'ai_actions';

  TextColumn get id => text()();
  TextColumn get conversationId => text().references(Conversations, #id)();
  TextColumn get actionType => text()();
  TextColumn get toolName => text()();
  TextColumn get proposedPayloadJson => text()();
  TextColumn get validatedPayloadJson => text()();
  TextColumn get beforeSnapshotJson => text()();
  TextColumn get afterSnapshotJson => text().nullable()();
  TextColumn get status => text()();
  TextColumn get confirmationTokenHash => text()();
  TextColumn get idempotencyKey => text().unique()();
  TextColumn get inputVersion => text()();
  IntColumn get expiresAt => integer()();
  IntColumn get confirmedAt => integer().nullable()();
  IntColumn get executedAt => integer().nullable()();
  IntColumn get undoneAt => integer().nullable()();
  TextColumn get errorCode => text().nullable()();
  IntColumn get createdAt => integer()();

  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{id};
}
