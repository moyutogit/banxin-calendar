import 'package:banxin_calendar/core/logging/sensitive_data_redactor.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final redactor = SensitiveDataRedactor();

  test('redacts sensitive structured fields recursively', () {
    final safe = redactor.redactFields(<String, Object?>{
      'requestId': 'request-1',
      'Authorization': 'Bearer abc',
      'nested': <String, Object?>{'wageAmount': 12345, 'status': 'ok'},
    });

    expect(safe['requestId'], 'request-1');
    expect(safe['Authorization'], SensitiveDataRedactor.redacted);
    expect(
      (safe['nested'] as Map<String, Object?>)['wageAmount'],
      SensitiveDataRedactor.redacted,
    );
  });

  test('redacts inline credentials', () {
    final safe = redactor.redactMessage('api-key=secret-value status=failed');

    expect(safe, isNot(contains('secret-value')));
    expect(safe, contains(SensitiveDataRedactor.redacted));
  });
}
