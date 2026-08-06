import 'package:banxin_calendar/features/assistant/domain/assistant_entities.dart';

final class ProviderConfigValidator {
  const ProviderConfigValidator({this.allowInsecureHttp = false});

  final bool allowInsecureHttp;

  Uri validateBaseUrl(String value) {
    final uri = Uri.tryParse(value.trim());
    if (uri == null || !uri.hasAuthority || uri.host.isEmpty) {
      throw const FormatException('Invalid provider URL.');
    }
    if (uri.userInfo.isNotEmpty) {
      throw const FormatException('Provider URL must not contain credentials.');
    }
    if (uri.scheme != 'https' && !(allowInsecureHttp && uri.scheme == 'http')) {
      throw const FormatException('HTTPS is required.');
    }
    return uri.replace(
      path: uri.path.endsWith('/') ? uri.path : '${uri.path}/',
    );
  }

  AiProviderConfig validate(AiProviderConfig config) {
    validateBaseUrl(config.baseUrl.toString());
    if (config.modelName.trim().isEmpty) {
      throw const FormatException('Model name is required.');
    }
    if (config.endpointPath.trim().isEmpty ||
        config.endpointPath.startsWith('http')) {
      throw const FormatException('Endpoint path must be relative.');
    }
    if (config.timeoutSeconds < 1 || config.timeoutSeconds > 300) {
      throw const FormatException('Timeout must be between 1 and 300 seconds.');
    }
    if (config.maxOutputTokens < 1 || config.maxOutputTokens > 32768) {
      throw const FormatException('Invalid output token limit.');
    }
    return config;
  }
}
