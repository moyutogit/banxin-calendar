import 'package:banxin_calendar/core/ids/stable_id_generator.dart';
import 'package:banxin_calendar/core/time/app_clock.dart';
import 'package:banxin_calendar/features/alarm/application/alarm_sync_service.dart';
import 'package:banxin_calendar/features/alarm/domain/alarm_entities.dart';
import 'package:banxin_calendar/features/alarm/domain/alarm_repository.dart';
import 'package:banxin_calendar/features/schedule/application/schedule_application_service.dart';
import 'package:banxin_calendar/features/schedule/domain/schedule_entities.dart';
import 'package:banxin_calendar/features/schedule/domain/value_objects.dart';

final class AlarmTemplateDraft {
  const AlarmTemplateDraft({
    this.id,
    required this.name,
    required this.mode,
    required this.minute,
    required this.vibrate,
    required this.volumeRamp,
    required this.snoozeMinutes,
    required this.maxSnoozeCount,
    required this.enabled,
    required this.shiftIds,
  });

  final String? id;
  final String name;
  final AlarmTemplateMode mode;
  final int minute;
  final bool vibrate;
  final bool volumeRamp;
  final int snoozeMinutes;
  final int maxSnoozeCount;
  final bool enabled;
  final Set<ShiftId> shiftIds;
}

final class AlarmSettingsView {
  const AlarmSettingsView({
    required this.capability,
    required this.templates,
    required this.shifts,
    required this.upcoming,
  });

  final AlarmCapability capability;
  final List<AlarmTemplate> templates;
  final List<StoredShiftTemplate> shifts;
  final List<AlarmInstance> upcoming;
}

final class AlarmApplicationService {
  AlarmApplicationService(
    this._repository,
    this._syncService,
    this._scheduleService, {
    StableIdGenerator? idGenerator,
    this._clock = const SystemAppClock(),
  }) : _idGenerator = idGenerator ?? UuidV4Generator();

  final AlarmRepository _repository;
  final AlarmSyncService _syncService;
  final ScheduleApplicationService _scheduleService;
  final StableIdGenerator _idGenerator;
  final AppClock _clock;

  Future<AlarmSettingsView> loadSettings() async {
    final rulesView = await _scheduleService.loadRulesView();
    return AlarmSettingsView(
      capability: await _syncService.capability(),
      templates: await _repository.loadTemplates(),
      shifts: rulesView.shifts,
      upcoming: await _repository.loadUpcomingInstances(_clock.nowUtc()),
    );
  }

  Future<AlarmSyncResult> saveTemplateAndSync(AlarmTemplateDraft draft) async {
    await _repository.saveTemplate(_fromDraft(draft));
    return syncRollingWindow();
  }

  Future<AlarmSyncResult> setTemplateEnabled(
    String id, {
    required bool enabled,
  }) async {
    await _repository.setTemplateEnabled(id, enabled: enabled);
    return syncRollingWindow();
  }

  Future<AlarmCapability> requestCapability() {
    return _syncService.requestCapability();
  }

  Future<AlarmSyncResult> deleteTemplate(String id) async {
    await _repository.deleteTemplate(id);
    return syncRollingWindow();
  }

  Future<AlarmSyncResult> syncRollingWindow() {
    final localNow = _clock.nowUtc().toLocal();
    final today = LocalDate(localNow.year, localNow.month, localNow.day);
    return _syncService.sync(DateRange(start: today, end: today.addDays(30)));
  }

  AlarmTemplateDraft draftFor(AlarmTemplate template) => AlarmTemplateDraft(
    id: template.id,
    name: template.name,
    mode: template.mode,
    minute: template.mode == AlarmTemplateMode.fixedTime
        ? template.fixedMinute!
        : template.offsetMinutes!,
    vibrate: template.vibrate,
    volumeRamp: template.volumeRamp,
    snoozeMinutes: template.snoozeMinutes,
    maxSnoozeCount: template.maxSnoozeCount,
    enabled: template.enabled,
    shiftIds: template.shiftIds,
  );

  AlarmTemplate _fromDraft(AlarmTemplateDraft draft) => AlarmTemplate(
    id: draft.id ?? _idGenerator.generate(),
    name: draft.name.trim(),
    mode: draft.mode,
    fixedMinute: draft.mode == AlarmTemplateMode.fixedTime
        ? draft.minute
        : null,
    offsetMinutes: draft.mode == AlarmTemplateMode.relativeToShiftStart
        ? draft.minute
        : null,
    vibrate: draft.vibrate,
    volumeRamp: draft.volumeRamp,
    snoozeMinutes: draft.snoozeMinutes,
    maxSnoozeCount: draft.maxSnoozeCount,
    enabled: draft.enabled,
    shiftIds: draft.shiftIds,
  );
}
