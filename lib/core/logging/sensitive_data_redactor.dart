class SensitiveDataRedactor {
  static const String redacted = '[REDACTED]';

  static final RegExp _sensitiveField = RegExp(
    r'(authorization|api[-_]?key|token|secret|credential|password|salary|wage|clock[-_]?in|clock[-_]?out|note|conversation)',
    caseSensitive: false,
  );

  static final RegExp _inlineCredential = RegExp(
    r'(authorization|api[-_]?key|token|secret|password)\s*[:=]\s*([^\s,;]+)',
    caseSensitive: false,
  );

  String redactMessage(String message) {
    return message.replaceAllMapped(
      _inlineCredential,
      (match) => '${match.group(1)}=$redacted',
    );
  }

  Map<String, Object?> redactFields(Map<String, Object?> fields) {
    return fields.map((key, value) {
      if (_sensitiveField.hasMatch(key)) {
        return MapEntry<String, Object?>(key, redacted);
      }
      return MapEntry<String, Object?>(key, _redactValue(value));
    });
  }

  Object? _redactValue(Object? value) {
    if (value is Map<String, Object?>) {
      return redactFields(value);
    }
    if (value is String) {
      return redactMessage(value);
    }
    return value;
  }
}
