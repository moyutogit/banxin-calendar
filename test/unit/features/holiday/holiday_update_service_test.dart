import 'dart:io';

import 'package:banxin_calendar/core/database/app_database.dart';
import 'package:banxin_calendar/core/time/app_clock.dart';
import 'package:banxin_calendar/features/holiday/application/holiday_update_service.dart';
import 'package:banxin_calendar/features/holiday/data/http_holiday_data_source.dart';
import 'package:banxin_calendar/features/holiday/domain/holiday_data_source.dart';
import 'package:banxin_calendar/features/schedule/data/drift_schedule_repository.dart';
import 'package:banxin_calendar/features/schedule/domain/schedule_entities.dart';
import 'package:banxin_calendar/features/schedule/domain/value_objects.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('parses the documented holiday-cn yearly schema', () async {
    Uri? requestedUri;
    final source = HttpHolidayDataSource(
      loader: (uri) async {
        requestedUri = uri;
        return _datasetJson;
      },
    );

    final dataset = await source.fetchYear(2026);

    expect(requestedUri?.path, endsWith('/2026.json'));
    expect(dataset.year, 2026);
    expect(dataset.dataVersion, startsWith('2026-'));
    expect(dataset.sourcePapers, <String>['https://www.gov.cn/fixture']);
    expect(dataset.records, hasLength(2));
    expect(dataset.records.first.status, DayStatus.publicHoliday);
    expect(dataset.records.last.status, DayStatus.adjustedWorkday);
  });

  test('falls back to the next trusted HTTPS source', () async {
    final requestedUris = <Uri>[];
    final source = HttpHolidayDataSource(
      baseUris: <Uri>[
        Uri.https('primary.example', '/holidays/'),
        Uri.https('fallback.example', '/holidays/'),
      ],
      loader: (uri) async {
        requestedUris.add(uri);
        if (uri.host == 'primary.example') {
          throw const SocketException('primary unavailable');
        }
        return _datasetJson;
      },
    );

    final dataset = await source.fetchYear(2026);

    expect(dataset.year, 2026);
    expect(requestedUris.map((uri) => uri.toString()), <String>[
      'https://primary.example/holidays/2026.json',
      'https://fallback.example/holidays/2026.json',
    ]);
  });

  test('rejects non-HTTPS holiday sources', () {
    expect(
      () => HttpHolidayDataSource(
        baseUri: Uri.parse('http://example.com/holidays/'),
      ),
      throwsArgumentError,
    );
  });

  test('keeps the last cached dataset when a refresh is offline', () async {
    final database = AppDatabase.inMemory();
    addTearDown(database.close);
    await database.ensureReady();
    final repository = DriftScheduleRepository(database);
    await repository.replaceOfficialHolidays(
      region: 'CN',
      dataVersion: 'cached',
      holidays: <HolidayImportRecord>[
        HolidayImportRecord(
          date: LocalDate.parse('2026-01-01'),
          name: '已缓存元旦',
          status: DayStatus.publicHoliday,
        ),
      ],
      updatedAt: 1,
    );
    final source = HttpHolidayDataSource(
      loader: (_) => throw const SocketException('offline'),
    );
    final service = HolidayUpdateService(
      source,
      repository,
      clock: _FixedClock(),
    );

    await expectLater(
      service.updateYear(2026),
      throwsA(
        isA<HolidayFetchException>().having(
          (error) => error.kind,
          'kind',
          HolidayFetchFailureKind.network,
        ),
      ),
    );

    final cached = await repository.loadOfficialHolidays(
      DateRange(
        start: LocalDate.parse('2026-01-01'),
        end: LocalDate.parse('2026-12-31'),
      ),
    );
    expect(cached, hasLength(1));
    expect(cached.keys.single, LocalDate.parse('2026-01-01'));
  });

  test('validates year and duplicate dates before touching storage', () {
    final parser = HolidayDatasetParser();
    expect(
      () => parser.parse(_datasetJson, expectedYear: 2025),
      throwsFormatException,
    );
    expect(
      () => parser.parse(
        _datasetJson.replaceFirst('2026-01-04', '2026-01-01'),
        expectedYear: 2026,
      ),
      throwsFormatException,
    );
  });
}

const _datasetJson = '''
{
  "year": 2026,
  "papers": ["https://www.gov.cn/fixture"],
  "days": [
    {"name": "元旦", "date": "2026-01-01", "isOffDay": true},
    {"name": "元旦", "date": "2026-01-04", "isOffDay": false}
  ]
}
''';

final class _FixedClock implements AppClock {
  @override
  DateTime nowUtc() => DateTime.utc(2026, 1, 1);
}
