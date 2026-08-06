import 'package:banxin_calendar/core/time/app_clock.dart';
import 'package:banxin_calendar/features/holiday/domain/holiday_data_source.dart';
import 'package:banxin_calendar/features/schedule/domain/schedule_entities.dart';
import 'package:banxin_calendar/features/schedule/domain/schedule_repository.dart';

final class HolidayUpdateResult {
  const HolidayUpdateResult({required this.dataset, required this.summary});

  final HolidayDataset dataset;
  final HolidayUpdateSummary summary;
}

final class HolidayUpdateService {
  const HolidayUpdateService(
    this._source,
    this._repository, {
    this._clock = const SystemAppClock(),
  });

  final HolidayDataSource _source;
  final ScheduleRepository _repository;
  final AppClock _clock;

  Future<HolidayUpdateResult> updateYear(int year) async {
    final dataset = await _source.fetchYear(year);
    final summary = await _repository.replaceOfficialHolidays(
      region: 'CN',
      dataVersion: dataset.dataVersion,
      holidays: dataset.records,
      updatedAt: _clock.nowUtc().millisecondsSinceEpoch,
    );
    return HolidayUpdateResult(dataset: dataset, summary: summary);
  }

  Future<bool> isEnabled() => _repository.isOfficialHolidayEnabled();

  Future<void> setEnabled({required bool enabled}) {
    return _repository.setOfficialHolidayEnabled(enabled: enabled);
  }
}
