import 'package:banxin_calendar/features/schedule/domain/schedule_entities.dart';

abstract interface class HolidayDataSource {
  Future<HolidayDataset> fetchYear(int year);
}

final class HolidayDataset {
  HolidayDataset({
    required this.year,
    required this.dataVersion,
    required List<String> sourcePapers,
    required List<HolidayImportRecord> records,
  }) : sourcePapers = List<String>.unmodifiable(sourcePapers),
       records = List<HolidayImportRecord>.unmodifiable(records);

  final int year;
  final String dataVersion;
  final List<String> sourcePapers;
  final List<HolidayImportRecord> records;
}
