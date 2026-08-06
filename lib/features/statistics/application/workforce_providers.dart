import 'package:banxin_calendar/core/database/database_providers.dart';
import 'package:banxin_calendar/features/attendance/application/attendance_application_service.dart';
import 'package:banxin_calendar/features/attendance/data/drift_attendance_repository.dart';
import 'package:banxin_calendar/features/attendance/domain/attendance_repository.dart';
import 'package:banxin_calendar/features/schedule/application/schedule_providers.dart';
import 'package:banxin_calendar/features/statistics/application/statistics_export_service.dart';
import 'package:banxin_calendar/features/statistics/application/statistics_service.dart';
import 'package:banxin_calendar/features/statistics/data/local_csv_exporter.dart';
import 'package:banxin_calendar/features/statistics/domain/csv_exporter.dart';
import 'package:banxin_calendar/features/wage/application/wage_application_service.dart';
import 'package:banxin_calendar/features/wage/data/drift_wage_repository.dart';
import 'package:banxin_calendar/features/wage/domain/wage_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final attendanceRepositoryProvider = Provider<AttendanceRepository>(
  (ref) => DriftAttendanceRepository(ref.watch(appDatabaseProvider)),
);

final attendanceApplicationServiceProvider =
    Provider<AttendanceApplicationService>(
      (ref) =>
          AttendanceApplicationService(ref.watch(attendanceRepositoryProvider)),
    );

final wageRepositoryProvider = Provider<WageRepository>(
  (ref) => DriftWageRepository(ref.watch(appDatabaseProvider)),
);

final wageApplicationServiceProvider = Provider<WageApplicationService>(
  (ref) => WageApplicationService(ref.watch(wageRepositoryProvider)),
);

final statisticsServiceProvider = Provider<StatisticsService>(
  (ref) => StatisticsService(
    ref.watch(scheduleApplicationServiceProvider),
    ref.watch(attendanceRepositoryProvider),
    ref.watch(wageRepositoryProvider),
  ),
);

final csvExporterProvider = Provider<CsvExporter>((ref) => LocalCsvExporter());

final statisticsExportServiceProvider = Provider<StatisticsExportService>(
  (ref) => StatisticsExportService(
    ref.watch(statisticsServiceProvider),
    ref.watch(csvExporterProvider),
  ),
);
