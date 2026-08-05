sealed class AppFailure implements Exception {
  const AppFailure({
    required this.code,
    required this.messageKey,
    required this.isRetryable,
    required this.diagnosticId,
    this.settingsRoute,
  });

  final String code;
  final String messageKey;
  final bool isRetryable;
  final String diagnosticId;
  final String? settingsRoute;
}

final class ValidationFailure extends AppFailure {
  const ValidationFailure({required super.code, required super.diagnosticId})
    : super(messageKey: 'error.validation', isRetryable: false);
}

final class PermissionFailure extends AppFailure {
  const PermissionFailure({
    required super.code,
    required super.diagnosticId,
    required super.settingsRoute,
  }) : super(messageKey: 'error.permission', isRetryable: true);
}

final class NetworkFailure extends AppFailure {
  const NetworkFailure({required super.code, required super.diagnosticId})
    : super(messageKey: 'error.network', isRetryable: true);
}

final class AuthenticationFailure extends AppFailure {
  const AuthenticationFailure({
    required super.code,
    required super.diagnosticId,
  }) : super(messageKey: 'error.authentication', isRetryable: false);
}

final class RateLimitFailure extends AppFailure {
  const RateLimitFailure({required super.code, required super.diagnosticId})
    : super(messageKey: 'error.rateLimit', isRetryable: true);
}

final class StorageFailure extends AppFailure {
  const StorageFailure({required super.code, required super.diagnosticId})
    : super(messageKey: 'error.storage', isRetryable: true);
}

final class ConflictFailure extends AppFailure {
  const ConflictFailure({required super.code, required super.diagnosticId})
    : super(messageKey: 'error.conflict', isRetryable: false);
}

final class PlatformFailure extends AppFailure {
  const PlatformFailure({required super.code, required super.diagnosticId})
    : super(messageKey: 'error.platform', isRetryable: true);
}

final class ProviderProtocolFailure extends AppFailure {
  const ProviderProtocolFailure({
    required super.code,
    required super.diagnosticId,
  }) : super(messageKey: 'error.providerProtocol', isRetryable: false);
}

final class UnknownFailure extends AppFailure {
  const UnknownFailure({required super.code, required super.diagnosticId})
    : super(messageKey: 'error.unknown', isRetryable: false);
}
