import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:banxin_calendar/core/secure_storage/secure_value_store.dart';

class SecureCredentialService {
  SecureCredentialService(this._store, {Random? secureRandom})
    : _secureRandom = secureRandom ?? Random.secure();

  final SecureValueStore _store;
  final Random _secureRandom;

  Future<String> save(String secret) async {
    if (secret.trim().isEmpty) {
      throw const FormatException('Credential must not be empty.');
    }

    final reference = _newReference();
    await _store.write(reference: reference, value: secret);
    return reference;
  }

  Future<String?> read(String reference) {
    return _store.read(reference: reference);
  }

  Future<void> delete(String reference) {
    return _store.delete(reference: reference);
  }

  String _newReference() {
    final bytes = Uint8List.fromList(
      List<int>.generate(32, (_) => _secureRandom.nextInt(256)),
    );
    return base64UrlEncode(bytes).replaceAll('=', '');
  }
}
