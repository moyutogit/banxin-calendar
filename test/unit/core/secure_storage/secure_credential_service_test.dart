import 'dart:math';

import 'package:banxin_calendar/core/secure_storage/secure_credential_service.dart';
import 'package:banxin_calendar/core/secure_storage/secure_value_store.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('stores only an opaque reference outside the caller', () async {
    final store = _MemorySecureValueStore();
    final service = SecureCredentialService(store, secureRandom: Random(42));
    const secret = 'sk-sensitive-value';

    final reference = await service.save(secret);

    expect(reference, isNot(contains(secret)));
    expect(reference, hasLength(greaterThanOrEqualTo(40)));
    expect(store.values[reference], secret);
    expect(await service.read(reference), secret);
  });

  test('rejects blank credentials', () async {
    final service = SecureCredentialService(
      _MemorySecureValueStore(),
      secureRandom: Random(7),
    );

    await expectLater(service.save('   '), throwsFormatException);
  });
}

class _MemorySecureValueStore implements SecureValueStore {
  final Map<String, String> values = <String, String>{};

  @override
  Future<void> delete({required String reference}) async {
    values.remove(reference);
  }

  @override
  Future<String?> read({required String reference}) async => values[reference];

  @override
  Future<void> write({required String reference, required String value}) async {
    values[reference] = value;
  }
}
