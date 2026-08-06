import 'package:banxin_calendar/features/holiday/application/holiday_update_service.dart';
import 'package:banxin_calendar/features/holiday/data/http_holiday_data_source.dart';
import 'package:banxin_calendar/features/holiday/domain/holiday_data_source.dart';
import 'package:banxin_calendar/features/schedule/application/schedule_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final holidayDataSourceProvider = Provider<HolidayDataSource>(
  (ref) => HttpHolidayDataSource(),
);

final holidayUpdateServiceProvider = Provider<HolidayUpdateService>(
  (ref) => HolidayUpdateService(
    ref.watch(holidayDataSourceProvider),
    ref.watch(scheduleRepositoryProvider),
  ),
);
