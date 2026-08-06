import 'package:banxin_calendar/features/alarm/domain/alarm_entities.dart';
import 'package:banxin_calendar/features/schedule/domain/value_objects.dart';

abstract interface class AlarmRepository {
  Future<List<AlarmTemplate>> loadTemplates({bool enabledOnly = false});

  Future<void> saveTemplate(AlarmTemplate template);

  Future<void> setTemplateEnabled(String id, {required bool enabled});

  Future<void> deleteTemplate(String id);

  Future<List<AlarmInstance>> loadInstances(DateRange range);

  Future<List<AlarmInstance>> loadUpcomingInstances(DateTime nowUtc);

  Future<void> markInstancesTriggered(Set<String> platformAlarmIds);

  Future<void> saveSyncChanges({
    required List<AlarmInstance> upserted,
    required Set<String> canceledPlatformIds,
  });
}
