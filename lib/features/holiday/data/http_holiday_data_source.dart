import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:banxin_calendar/features/holiday/domain/holiday_data_source.dart';
import 'package:banxin_calendar/features/schedule/domain/schedule_entities.dart';
import 'package:banxin_calendar/features/schedule/domain/value_objects.dart';

typedef HolidayDocumentLoader = Future<String> Function(Uri uri);

final class HttpHolidayDataSource implements HolidayDataSource {
  factory HttpHolidayDataSource({
    HolidayDocumentLoader? loader,
    Uri? baseUri,
    List<Uri>? baseUris,
  }) {
    if (baseUri != null && baseUris != null) {
      throw ArgumentError('Specify either baseUri or baseUris, not both.');
    }
    final resolvedBaseUris =
        baseUris ?? (baseUri == null ? _defaultBaseUris : <Uri>[baseUri]);
    if (resolvedBaseUris.isEmpty) {
      throw ArgumentError.value(baseUris, 'baseUris', 'Must not be empty.');
    }
    for (final uri in resolvedBaseUris) {
      if (uri.scheme != 'https' || uri.host.isEmpty) {
        throw ArgumentError.value(
          uri,
          'baseUris',
          'Holiday data sources must use HTTPS.',
        );
      }
    }
    return HttpHolidayDataSource._(
      loader ?? _loadDocument,
      List<Uri>.unmodifiable(resolvedBaseUris),
    );
  }

  const HttpHolidayDataSource._(this._loader, this.baseUris);

  static const int _maximumDocumentBytes = 1024 * 1024;
  static final List<Uri> _defaultBaseUris = <Uri>[
    Uri.https('cdn.jsdelivr.net', '/gh/NateScarlet/holiday-cn@master/'),
    Uri.https('raw.githubusercontent.com', '/NateScarlet/holiday-cn/master/'),
  ];

  final HolidayDocumentLoader _loader;
  final List<Uri> baseUris;

  @override
  Future<HolidayDataset> fetchYear(int year) async {
    if (year < 2000 || year > 9999) {
      throw RangeError.range(year, 2000, 9999, 'year');
    }
    final attemptedUris = <Uri>[];
    final failureKinds = <HolidayFetchFailureKind>[];
    for (final baseUri in baseUris) {
      final uri = baseUri.resolve('$year.json');
      attemptedUris.add(uri);
      try {
        final source = await _loader(uri);
        if (utf8.encode(source).length > _maximumDocumentBytes) {
          throw const FormatException(
            'Holiday document exceeds the size limit.',
          );
        }
        return HolidayDatasetParser().parse(source, expectedYear: year);
      } on Exception catch (error) {
        failureKinds.add(_failureKind(error));
      }
    }
    throw HolidayFetchException(
      kind: _combinedFailureKind(failureKinds),
      attemptedUris: attemptedUris,
    );
  }

  HolidayFetchFailureKind _failureKind(Exception error) {
    if (error is _HolidayHttpException &&
        error.statusCode == HttpStatus.notFound) {
      return HolidayFetchFailureKind.notFound;
    }
    if (error is TimeoutException || error is IOException) {
      return HolidayFetchFailureKind.network;
    }
    if (error is FormatException) {
      return HolidayFetchFailureKind.invalidData;
    }
    return HolidayFetchFailureKind.unexpected;
  }

  HolidayFetchFailureKind _combinedFailureKind(
    List<HolidayFetchFailureKind> failures,
  ) {
    if (failures.every(
      (failure) => failure == HolidayFetchFailureKind.notFound,
    )) {
      return HolidayFetchFailureKind.notFound;
    }
    if (failures.contains(HolidayFetchFailureKind.network)) {
      return HolidayFetchFailureKind.network;
    }
    if (failures.contains(HolidayFetchFailureKind.invalidData)) {
      return HolidayFetchFailureKind.invalidData;
    }
    return HolidayFetchFailureKind.unexpected;
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
        throw _HolidayHttpException(response.statusCode, uri: uri);
      }
      return response.transform(utf8.decoder).join();
    } finally {
      client.close(force: true);
    }
  }
}

final class _HolidayHttpException extends HttpException {
  _HolidayHttpException(this.statusCode, {required Uri uri})
    : super('Holiday data request returned HTTP $statusCode.', uri: uri);

  final int statusCode;
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
