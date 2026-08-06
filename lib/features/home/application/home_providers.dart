import 'package:banxin_calendar/features/alarm/application/alarm_providers.dart';
import 'package:banxin_calendar/features/home/application/home_application_service.dart';
import 'package:banxin_calendar/features/schedule/application/schedule_providers.dart';
import 'package:banxin_calendar/features/statistics/application/workforce_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeApplicationServiceProvider = Provider<HomeApplicationService>(
  (ref) => HomeApplicationService(
    ref.watch(scheduleApplicationServiceProvider),
    ref.watch(attendanceApplicationServiceProvider),
    ref.watch(statisticsServiceProvider),
    ref.watch(alarmRepositoryProvider),
  ),
);
