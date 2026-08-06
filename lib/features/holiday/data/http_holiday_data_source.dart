import 'dart:convert';
import 'dart:io';

import 'package:banxin_calendar/features/holiday/domain/holiday_data_source.dart';
import 'package:banxin_calendar/features/schedule/domain/schedule_entities.dart';
import 'package:banxin_calendar/features/schedule/domain/value_objects.dart';

typedef HolidayDocumentLoader = Future<String> Function(Uri uri);

final class HttpHolidayDataSource implements HolidayDataSource {
  HttpHolidayDataSource({HolidayDocumentLoader? loader, Uri? baseUri})
    : _loader = loader ?? _loadDocument,
      baseUri =
          baseUri ??
          Uri.https(
            'raw.githubusercontent.com',
            '/NateScarlet/holiday-cn/master/',
          );

  static const int _maximumDocumentBytes = 1024 * 1024;

  final HolidayDocumentLoader _loader;
  final Uri baseUri;

  @override
  Future<HolidayDataset> fetchYear(int year) async {
    if (year < 2000 || year > 9999) {
      throw RangeError.range(year, 2000, 9999, 'year');
    }
    final uri = baseUri.resolve('$year.json');
    final source = await _loader(uri);
    if (utf8.encode(source).length > _maximumDocumentBytes) {
      throw const FormatException('Holiday document exceeds the size limit.');
    }
    return HolidayDatasetParser().parse(source, expectedYear: year);
  }

  static Future<String> _loadDocument(Uri uri) async {
    final client = HttpClient()
      ..connectionTimeout = const Duration(seconds: 15);
    try {
      final request = await client.getUrl(uri);
      request.headers.set(HttpHeaders.acceptHeader, 'application/json');
      request.headers.set(
        HttpHeaders.userAgentHeader,
        'banxin-calendar/0.1 holiday-updater',
      );
      final response = await request.close().timeout(
        const Duration(seconds: 20),
      );
      if (response.statusCode != HttpStatus.ok) {
        await response.drain<void>();
        throw HttpException(
          'Holiday data request returned HTTP ${response.statusCode}.',
          uri: uri,
        );
      }
      return response.transform(utf8.decoder).join();
    } finally {
      client.close(force: true);
    }
  }
}

final class HolidayDatasetParser {
  HolidayDataset parse(String source, {required int expectedYear}) {
    final decoded = jsonDecode(source);
    if (decoded is! Map<String, Object?>) {
      throw const FormatException('Holiday document must be an object.');
    }
    final year = decoded['year'];
    if (year is! int || year != expectedYear) {
      throw FormatException(
        'Holiday document year does not match $expectedYear.',
      );
    }
    final papersValue = decoded['papers'];
    if (papersValue is! List<Object?> ||
        papersValue.any((paper) => paper is! String)) {
      throw const FormatException('Holiday papers must be an array of URLs.');
    }
    final daysValue = decoded['days'];
    if (daysValue is! List<Object?>) {
      throw const FormatException('Holiday days must be an array.');
    }
    final records = daysValue
        .map((value) {
          if (value is! Map<String, Object?>) {
            throw const FormatException('Holiday day must be an object.');
          }
          final name = value['name'];
          final date = value['date'];
          final isOffDay = value['isOffDay'];
          if (name is! String || date is! String || isOffDay is! bool) {
            throw const FormatException('Holiday day fields are invalid.');
          }
          return HolidayImportRecord(
            date: LocalDate.parse(date),
            name: name,
            status: isOffDay
                ? DayStatus.publicHoliday
                : DayStatus.adjustedWorkday,
          );
        })
        .toList(growable: false);
    final uniqueDates = records.map((record) => record.date).toSet();
    if (uniqueDates.length != records.length) {
      throw const FormatException('Holiday document contains duplicate dates.');
    }
    return HolidayDataset(
      year: year,
      dataVersion: '$year-${_fnv1a64(utf8.encode(source))}',
      sourcePapers: papersValue.cast<String>(),
      records: records,
    );
  }

  String _fnv1a64(List<int> bytes) {
    var hash = 0xcbf29ce484222325;
    for (final byte in bytes) {
      hash ^= byte;
      hash = (hash * 0x100000001b3) & 0xFFFFFFFFFFFFFFFF;
    }
    return hash.toRadixString(16).padLeft(16, '0');
  }
}
