import 'package:banxin_calendar/features/schedule/domain/schedule_entities.dart';
import 'package:banxin_calendar/features/schedule/domain/schedule_repository.dart';
import 'package:banxin_calendar/features/schedule/domain/schedule_resolver.dart';
import 'package:banxin_calendar/features/schedule/domain/schedule_rules.dart';
import 'package:banxin_calendar/features/schedule/domain/value_objects.dart';

final class ResolveCalendarRange {
  const ResolveCalendarRange(this._repository, this._resolver);

  final ScheduleRepository _repository;
  final ScheduleResolver _resolver;

  Future<List<ResolvedCalendarDay>> call({
    required DateRange range,
    required WeekTemplate defaultWeek,
  }) async {
    final inputVersion = await _repository.loadInputVersion();
    final cached = await _repository.loadCachedDays(
      range: range,
      inputVersion: inputVersion,
      resolverVersion: ScheduleResolver.resolverVersion,
    );
    if (cached.length == range.start.daysUntil(range.end) + 1 &&
        range.dates.every(cached.containsKey)) {
      return List<ResolvedCalendarDay>.unmodifiable(
        range.dates.map((date) => cached[date]!),
      );
    }

    final rulesFuture = _repository.loadRules(range);
    final userOverridesFuture = _repository.loadUserOverrides(range);
    final companyOverridesFuture = _repository.loadCompanyOverrides(range);
    final holidaysFuture = _repository.loadOfficialHolidays(range);

    final input = ScheduleResolverInput(
      defaultWeek: defaultWeek,
      rules: await rulesFuture,
      userOverrides: await userOverridesFuture,
      companyOverrides: await companyOverridesFuture,
      officialHolidays: await holidaysFuture,
    );
    final resolved = _resolver.resolveRange(range, input);
    await _repository.replaceCachedDays(
      days: resolved,
      inputVersion: inputVersion,
    );
    return resolved;
  }
}
