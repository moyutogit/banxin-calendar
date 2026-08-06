import 'package:banxin_calendar/core/database/database_providers.dart';
import 'package:banxin_calendar/features/schedule/application/resolve_calendar_range.dart';
import 'package:banxin_calendar/features/schedule/data/drift_schedule_repository.dart';
import 'package:banxin_calendar/features/schedule/domain/schedule_repository.dart';
import 'package:banxin_calendar/features/schedule/domain/schedule_resolver.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final scheduleResolverProvider = Provider<ScheduleResolver>(
  (ref) => ScheduleResolver(),
);

final scheduleRepositoryProvider = Provider<ScheduleRepository>(
  (ref) => DriftScheduleRepository(ref.watch(appDatabaseProvider)),
);

final resolveCalendarRangeProvider = Provider<ResolveCalendarRange>(
  (ref) => ResolveCalendarRange(
    ref.watch(scheduleRepositoryProvider),
    ref.watch(scheduleResolverProvider),
  ),
);
