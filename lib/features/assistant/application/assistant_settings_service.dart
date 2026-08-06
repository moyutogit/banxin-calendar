import 'dart:convert';

import 'package:banxin_calendar/core/ids/stable_id_generator.dart';
import 'package:banxin_calendar/core/secure_storage/secure_credential_service.dart';
import 'package:banxin_calendar/core/time/app_clock.dart';
import 'package:banxin_calendar/features/assistant/domain/assistant_entities.dart';
import 'package:banxin_calendar/features/assistant/domain/assistant_repository.dart';
import 'package:banxin_calendar/features/assistant/domain/llm_provider.dart';
import 'package:banxin_calendar/features/assistant/domain/provider_config_validator.dart';

final class AiProviderConfigDraft {
  const AiProviderConfigDraft({
    required this.providerType,
    required this.baseUrl,
    required this.endpointPath,
    required this.modelName,
    required this.apiKey,
    required this.customHeaders,
    required this.timeoutSeconds,
    required this.maxOutputTokens,
    required this.streamEnabled,
  });

  final AiProviderType providerType;
  final String baseUrl;
  final String endpointPath;
  final String? apiKey;
  final Map<String, String> customHeaders;
  final String modelName;
  final int timeoutSeconds;
  final int maxOutputTokens;
  final bool streamEnabled;
}

final class AssistantSettingsView {
  const AssistantSettingsView({required this.config, required this.persona});

  final AiProviderConfig? config;
  final AssistantPersona persona;
}

final class AssistantSettingsService {
  AssistantSettingsService(
    this._repository,
    this._credentials,
    this._provider, {
    this._validator = const ProviderConfigValidator(),
    this._clock = const SystemAppClock(),
    StableIdGenerator? idGenerator,
  }) : _idGenerator = idGenerator ?? UuidV4Generator();

  final AssistantRepository _repository;
  final SecureCredentialService _credentials;
  final LlmProvider _provider;
  final ProviderConfigValidator _validator;
  final AppClock _clock;
  final StableIdGenerator _idGenerator;

  Future<AssistantSettingsView> load() async => AssistantSettingsView(
    config: await _repository.loadProviderConfig(),
    persona: await _repository.loadPersona(),
  );

  Future<AiProviderConfig> saveProvider(
    AiProviderConfigDraft draft, {
    required bool confirmHostChange,
  }) async {
    final existing = await _repository.loadProviderConfig();
    final baseUrl = _validator.validateBaseUrl(draft.baseUrl);
    if (existing != null &&
        existing.baseUrl.host != baseUrl.host &&
        !confirmHostChange) {
      throw const FormatException(
        'Provider host change requires confirmation.',
      );
    }
    if ((draft.apiKey == null || draft.apiKey!.isEmpty) && existing == null) {
      throw const FormatException('API credential is required.');
    }
    String? newCredentialRef;
    String? newHeadersRef;
    try {
      newCredentialRef = draft.apiKey == null || draft.apiKey!.isEmpty
          ? existing!.credentialRef
          : await _credentials.save(draft.apiKey!);
      newHeadersRef = draft.customHeaders.isEmpty
          ? null
          : await _credentials.save(jsonEncode(draft.customHeaders));
      final config = _validator.validate(
        AiProviderConfig(
          id: existing?.id ?? _idGenerator.generate(),
          providerType: draft.providerType,
          baseUrl: baseUrl,
          endpointPath: draft.endpointPath,
          modelName: draft.modelName.trim(),
          credentialRef: newCredentialRef,
          customHeadersRef: newHeadersRef,
          timeoutSeconds: draft.timeoutSeconds,
          maxOutputTokens: draft.maxOutputTokens,
          streamEnabled: draft.streamEnabled,
          connectionStatus: AiConnectionStatus.notTested,
        ),
      );
      await _repository.saveProviderConfig(config);
      if (existing != null &&
          draft.apiKey != null &&
          draft.apiKey!.isNotEmpty &&
          existing.credentialRef != newCredentialRef) {
        await _credentials.delete(existing.credentialRef);
      }
      if (existing?.customHeadersRef != null &&
          existing!.customHeadersRef != newHeadersRef) {
        await _credentials.delete(existing.customHeadersRef!);
      }
      return config;
    } catch (_) {
      if (newCredentialRef != null &&
          newCredentialRef != existing?.credentialRef) {
        await _credentials.delete(newCredentialRef);
      }
      if (newHeadersRef != null &&
          newHeadersRef != existing?.customHeadersRef) {
        await _credentials.delete(newHeadersRef);
      }
      rethrow;
    }
  }

  Future<ConnectionTestResult> testConnection() async {
    final config = await _repository.loadProviderConfig();
    if (config == null) {
      return const ConnectionTestResult(AiConnectionStatus.notTested);
    }
    final secrets = await _secrets(config);
    final result = await _provider.testConnection(
      config: config,
      credential: secrets.$1,
      customHeaders: secrets.$2,
    );
    await _repository.saveProviderConfig(
      AiProviderConfig(
        id: config.id,
        providerType: config.providerType,
        baseUrl: config.baseUrl,
        endpointPath: config.endpointPath,
        modelName: config.modelName,
        credentialRef: config.credentialRef,
        customHeadersRef: config.customHeadersRef,
        timeoutSeconds: config.timeoutSeconds,
        maxOutputTokens: config.maxOutputTokens,
        streamEnabled: config.streamEnabled,
        connectionStatus: result.status,
        lastTestedAtUtc: _clock.nowUtc(),
      ),
    );
    return result;
  }

  Future<void> savePersona(AssistantPersona persona) {
    return _repository.savePersona(persona);
  }

  Future<(String, Map<String, String>)> secrets(AiProviderConfig config) =>
      _secrets(config);

  Future<(String, Map<String, String>)> _secrets(
    AiProviderConfig config,
  ) async {
    final credential = await _credentials.read(config.credentialRef);
    if (credential == null) throw StateError('Credential is unavailable.');
    final headersRaw = config.customHeadersRef == null
        ? null
        : await _credentials.read(config.customHeadersRef!);
    final headers = headersRaw == null
        ? <String, String>{}
        : (jsonDecode(headersRaw) as Map<String, Object?>).map(
            (key, value) => MapEntry(key, value! as String),
          );
    return (credential, headers);
  }
}
