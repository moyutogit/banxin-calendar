import 'package:banxin_calendar/features/alarm/domain/alarm_entities.dart';
import 'package:banxin_calendar/features/schedule/domain/value_objects.dart';

abstract interface class AlarmRepository {
  Future<List<AlarmTemplate>> loadTemplates({bool enabledOnly = false});

  Future<void> saveTemplate(AlarmTemplate template);

  Future<void> setTemplateEnabled(String id, {required bool enabled});

  Future<List<AlarmInstance>> loadInstances(DateRange range);

  Future<List<AlarmInstance>> loadUpcomingInstances(DateTime nowUtc);

  Future<void> saveSyncChanges({
    required List<AlarmInstance> upserted,
    required Set<String> canceledPlatformIds,
  });
}
