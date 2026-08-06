import 'package:banxin_calendar/features/schedule/domain/value_objects.dart';
import 'package:banxin_calendar/features/wage/domain/wage_entities.dart';

abstract interface class WageRepository {
  Future<List<WageRule>> loadRules(DateRange range);

  Future<void> saveRule(WageRule rule);

  Future<PayrollPeriod?> loadPayrollPeriod(DateRange range);

  Future<void> savePayrollPeriod(PayrollPeriod period);
}
