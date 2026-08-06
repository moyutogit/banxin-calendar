import 'package:banxin_calendar/features/schedule/domain/schedule_entities.dart';

abstract interface class HolidayDataSource {
  Future<HolidayDataset> fetchYear(int year);
}

enum HolidayFetchFailureKind { network, notFound, invalidData, unexpected }

final class HolidayFetchException implements Exception {
  HolidayFetchException({required this.kind, required List<Uri> attemptedUris})
    : attemptedUris = List<Uri>.unmodifiable(attemptedUris);

  final HolidayFetchFailureKind kind;
  final List<Uri> attemptedUris;

  @override
  String toString() {
    return 'HolidayFetchException($kind, attempts: ${attemptedUris.length})';
  }
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
