import 'package:drift/drift.dart';

class AiProviderConfigs extends Table {
  @override
  String get tableName => 'ai_provider_configs';

  TextColumn get id => text()();
  TextColumn get providerType => text()();
  TextColumn get baseUrl => text()();
  TextColumn get endpointPath => text()();
  TextColumn get modelName => text()();
  TextColumn get credentialRef => text()();
  TextColumn get customHeadersRef => text().nullable()();
  IntColumn get timeoutSeconds => integer()();
  IntColumn get maxOutputTokens => integer()();
  IntColumn get streamEnabled => integer()();
  TextColumn get connectionStatus => text()();
  IntColumn get lastTestedAt => integer().nullable()();
  IntColumn get createdAt => integer()();
  IntColumn get updatedAt => integer()();

  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{id};
}
