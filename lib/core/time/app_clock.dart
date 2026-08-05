abstract interface class AppClock {
  DateTime nowUtc();
}

class SystemAppClock implements AppClock {
  const SystemAppClock();

  @override
  DateTime nowUtc() => DateTime.now().toUtc();
}
