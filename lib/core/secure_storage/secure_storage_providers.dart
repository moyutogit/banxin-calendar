import 'package:banxin_calendar/core/secure_storage/flutter_secure_value_store.dart';
import 'package:banxin_calendar/core/secure_storage/secure_credential_service.dart';
import 'package:banxin_calendar/core/secure_storage/secure_value_store.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final secureValueStoreProvider = Provider<SecureValueStore>(
  (ref) => FlutterSecureValueStore(),
);

final secureCredentialServiceProvider = Provider<SecureCredentialService>(
  (ref) => SecureCredentialService(ref.watch(secureValueStoreProvider)),
);
