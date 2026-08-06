import 'package:banxin_calendar/features/schedule/domain/value_objects.dart';
import 'package:banxin_calendar/features/statistics/application/statistics_service.dart';
import 'package:banxin_calendar/features/statistics/domain/csv_exporter.dart';

final class StatisticsExportService {
  const StatisticsExportService(this._statistics, this._exporter);

  final StatisticsService _statistics;
  final CsvExporter _exporter;

  Future<String> export(DateRange range) async {
    final report = await _statistics.build(range);
    return _exporter.write(
      fileName: 'banxin_${range.start}_${range.end}.csv',
      bytes: _statistics.csvBytes(report),
    );
  }
}
