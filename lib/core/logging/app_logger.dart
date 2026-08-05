import 'dart:convert';

import 'package:banxin_calendar/core/logging/sensitive_data_redactor.dart';
import 'package:logging/logging.dart';

class AppLogger {
  AppLogger(String name, {SensitiveDataRedactor? redactor})
    : _logger = Logger(name),
      _redactor = redactor ?? SensitiveDataRedactor();

  final Logger _logger;
  final SensitiveDataRedactor _redactor;

  void event(
    Level level,
    String eventName, {
    Map<String, Object?> fields = const <String, Object?>{},
  }) {
    final safePayload = <String, Object?>{
      'event': _redactor.redactMessage(eventName),
      ..._redactor.redactFields(fields),
    };
    _logger.log(level, jsonEncode(safePayload));
  }
}
