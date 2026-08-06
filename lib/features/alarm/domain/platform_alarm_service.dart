import 'package:banxin_calendar/features/alarm/domain/alarm_entities.dart';

abstract interface class PlatformAlarmService {
  Future<AlarmCapability> capability();

  Future<AlarmCapability> requestCapability();

  Future<void> schedule(PlatformAlarmRequest request);

  Future<void> cancel(String platformAlarmId);

  Future<Set<String>> listManagedAlarmIds();

  Future<Set<String>> consumeTriggeredAlarmIds();
}
