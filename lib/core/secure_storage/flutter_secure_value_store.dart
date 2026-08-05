import 'package:banxin_calendar/core/secure_storage/secure_value_store.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class FlutterSecureValueStore implements SecureValueStore {
  FlutterSecureValueStore({FlutterSecureStorage? storage})
    : _storage = storage ?? const FlutterSecureStorage();

  static const String _namespace = 'banxin.credentials.';

  final FlutterSecureStorage _storage;

  @override
  Future<void> delete({required String reference}) {
    return _storage.delete(key: _key(reference));
  }

  @override
  Future<String?> read({required String reference}) {
    return _storage.read(key: _key(reference));
  }

  @override
  Future<void> write({required String reference, required String value}) {
    if (value.isEmpty) {
      throw const FormatException('Secure values must not be empty.');
    }
    return _storage.write(key: _key(reference), value: value);
  }

  String _key(String reference) {
    if (!RegExp(r'^[A-Za-z0-9_-]{20,}$').hasMatch(reference)) {
      throw const FormatException('Invalid secure storage reference.');
    }
    return '$_namespace$reference';
  }
}
