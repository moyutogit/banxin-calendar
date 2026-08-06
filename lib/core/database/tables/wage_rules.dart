import 'package:drift/drift.dart';

class WageRules extends Table {
  @override
  String get tableName => 'wage_rules';

  TextColumn get id => text()();
  TextColumn get mode => text()();
  TextColumn get currency => text()();
  IntColumn get baseRateMinor => integer()();
  TextColumn get overtimeRatesJson => text()();
  TextColumn get allowanceRulesJson => text()();
  TextColumn get deductionRulesJson => text()();
  IntColumn get periodStartDay => integer()();
  TextColumn get roundingRuleJson => text()();
  IntColumn get confirmedOnly =>
      integer().withDefault(const Constant<int>(0))();
  TextColumn get effectiveStart => text()();
  TextColumn get effectiveEnd => text().nullable()();
  IntColumn get createdAt => integer()();
  IntColumn get updatedAt => integer()();

  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{id};
}
