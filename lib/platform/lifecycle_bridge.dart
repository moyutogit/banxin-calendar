enum AppLifecycleSignal { resumed, timezoneChanged, systemTimeChanged }

abstract interface class LifecycleBridge {
  Stream<AppLifecycleSignal> get signals;
}
