import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:banxin_calendar/features/assistant/domain/assistant_entities.dart';
import 'package:banxin_calendar/features/assistant/domain/llm_provider.dart';

final class LlmProviderException implements Exception {
  const LlmProviderException(this.status);

  final AiConnectionStatus status;

  @override
  String toString() => 'LlmProviderException(${status.name})';
}

final class DartIoLlmProvider implements LlmProvider {
  const DartIoLlmProvider();

  @override
  Stream<LlmEvent> chat({
    required List<LlmMessage> messages,
    required List<ToolDefinition> tools,
    required AiProviderConfig config,
    required String credential,
    required Map<String, String> customHeaders,
  }) async* {
    final client = HttpClient()
      ..connectionTimeout = Duration(seconds: config.timeoutSeconds);
    try {
      final replayReasoning = _supportsDeepSeekReasoning(config);
      final request = await client
          .postUrl(config.endpoint)
          .timeout(Duration(seconds: config.timeoutSeconds));
      _applyHeaders(request, credential, customHeaders);
      if (config.streamEnabled) {
        request.headers.set(HttpHeaders.acceptHeader, 'text/event-stream');
      }
      request.write(
        jsonEncode(<String, Object?>{
          'model': config.modelName,
          'messages': <Object?>[
            for (final message in messages)
              <String, Object?>{
                'role': message.role.name,
                'content': message.content,
                'reasoning_content': ?(replayReasoning
                    ? message.reasoningContent
                    : null),
                if (message.toolCalls.isNotEmpty)
                  'tool_calls': <Object?>[
                    for (final call in message.toolCalls)
                      <String, Object?>{
                        'id': call.id,
                        'type': 'function',
                        'function': <String, Object?>{
                          'name': call.name,
                          'arguments': jsonEncode(call.arguments),
                        },
                      },
                  ],
                'tool_call_id': ?message.toolCallId,
              },
          ],
          if (tools.isNotEmpty)
            'tools': <Object?>[
              for (final tool in tools)
                <String, Object?>{
                  'type': 'function',
                  'function': <String, Object?>{
                    'name': tool.name,
                    'description': tool.description,
                    'parameters': tool.parametersSchema,
                  },
                },
            ],
          'max_tokens': config.maxOutputTokens,
          'stream': config.streamEnabled,
        }),
      );
      final response = await request.close().timeout(
        Duration(seconds: config.timeoutSeconds),
      );
      if (response.statusCode < 200 || response.statusCode >= 300) {
        await response.drain<void>();
        throw LlmProviderException(_statusForHttp(response.statusCode));
      }
      if (config.streamEnabled) {
        final calls = <int, _StreamingToolCall>{};
        var completed = false;
        await for (final line
            in response
                .transform(utf8.decoder)
                .transform(const LineSplitter())) {
          if (!line.startsWith('data:')) continue;
          final data = line.substring(5).trim();
          if (data == '[DONE]') {
            for (final call
                in calls.entries.toList()
                  ..sort((left, right) => left.key.compareTo(right.key))) {
              yield call.value.toEvent();
            }
            yield const LlmCompleted();
            completed = true;
            break;
          }
          final decoded = jsonDecode(data) as Map<String, Object?>;
          final choices = decoded['choices'] as List<Object?>?;
          if (choices == null || choices.isEmpty) continue;
          final choice = choices.first! as Map<String, Object?>;
          final delta = choice['delta'] as Map<String, Object?>?;
          final reasoning = delta?['reasoning_content'] as String?;
          if (reasoning != null && reasoning.isNotEmpty) {
            yield LlmReasoningDelta(reasoning);
          }
          final text = delta?['content'] as String?;
          if (text != null && text.isNotEmpty) yield LlmTextDelta(text);
          final fragments =
              delta?['tool_calls'] as List<Object?>? ?? const <Object?>[];
          for (final raw in fragments) {
            final fragment = raw! as Map<String, Object?>;
            final index = fragment['index'] as int? ?? 0;
            final call = calls.putIfAbsent(index, _StreamingToolCall.new);
            call.add(fragment);
          }
        }
        if (!completed) {
          for (final call
              in calls.entries.toList()
                ..sort((left, right) => left.key.compareTo(right.key))) {
            yield call.value.toEvent();
          }
          yield const LlmCompleted();
        }
      } else {
        final body = await response.transform(utf8.decoder).join();
        yield* _decodeComplete(body);
      }
    } on LlmProviderException {
      rethrow;
    } on TimeoutException {
      throw const LlmProviderException(AiConnectionStatus.timeout);
    } on HandshakeException {
      throw const LlmProviderException(AiConnectionStatus.tlsFailure);
    } on SocketException {
      throw const LlmProviderException(AiConnectionStatus.networkFailure);
    } on FormatException {
      throw const LlmProviderException(AiConnectionStatus.incompatibleResponse);
    } finally {
      client.close(force: true);
    }
  }

  @override
  Future<ConnectionTestResult> testConnection({
    required AiProviderConfig config,
    required String credential,
    required Map<String, String> customHeaders,
  }) async {
    try {
      await chat(
        messages: const <LlmMessage>[
          LlmMessage(role: LlmRole.user, content: 'Reply OK.'),
        ],
        tools: const <ToolDefinition>[],
        config: AiProviderConfig(
          id: config.id,
          providerType: config.providerType,
          baseUrl: config.baseUrl,
          endpointPath: config.endpointPath,
          modelName: config.modelName,
          credentialRef: config.credentialRef,
          customHeadersRef: config.customHeadersRef,
          timeoutSeconds: config.timeoutSeconds,
          maxOutputTokens: 2,
          streamEnabled: false,
          connectionStatus: config.connectionStatus,
        ),
        credential: credential,
        customHeaders: customHeaders,
      ).drain<void>();
      return const ConnectionTestResult(AiConnectionStatus.connected);
    } on LlmProviderException catch (error) {
      return ConnectionTestResult(error.status);
    }
  }

  Stream<LlmEvent> _decodeComplete(String body) async* {
    final decoded = jsonDecode(body) as Map<String, Object?>;
    final choices = decoded['choices'] as List<Object?>?;
    if (choices == null || choices.isEmpty) throw const FormatException();
    final choice = choices.first! as Map<String, Object?>;
    final message = choice['message'] as Map<String, Object?>?;
    if (message == null) throw const FormatException();
    final reasoning = message['reasoning_content'] as String?;
    if (reasoning != null && reasoning.isNotEmpty) {
      yield LlmReasoningDelta(reasoning);
    }
    final content = message['content'] as String?;
    if (content != null && content.isNotEmpty) yield LlmTextDelta(content);
    final calls = message['tool_calls'] as List<Object?>? ?? const <Object?>[];
    for (final raw in calls) {
      final call = raw! as Map<String, Object?>;
      final function = call['function']! as Map<String, Object?>;
      final arguments = jsonDecode(function['arguments']! as String);
      if (arguments is! Map<String, Object?>) throw const FormatException();
      yield LlmToolCall(
        id: call['id']! as String,
        name: function['name']! as String,
        arguments: arguments,
      );
    }
    yield const LlmCompleted();
  }

  void _applyHeaders(
    HttpClientRequest request,
    String credential,
    Map<String, String> customHeaders,
  ) {
    request.headers.contentType = ContentType.json;
    request.headers.set(HttpHeaders.authorizationHeader, 'Bearer $credential');
    for (final entry in customHeaders.entries) {
      final normalized = entry.key.toLowerCase();
      if (normalized == HttpHeaders.hostHeader ||
          normalized == HttpHeaders.contentLengthHeader ||
          normalized == HttpHeaders.authorizationHeader) {
        continue;
      }
      request.headers.set(entry.key, entry.value);
    }
  }

  AiConnectionStatus _statusForHttp(int status) => switch (status) {
    401 || 403 => AiConnectionStatus.authenticationFailure,
    404 => AiConnectionStatus.modelNotFound,
    402 => AiConnectionStatus.insufficientBalance,
    429 => AiConnectionStatus.rateLimited,
    _ => AiConnectionStatus.networkFailure,
  };

  bool _supportsDeepSeekReasoning(AiProviderConfig config) {
    final host = config.baseUrl.host.toLowerCase();
    final model = config.modelName.toLowerCase();
    return host == 'api.deepseek.com' ||
        host.endsWith('.deepseek.com') ||
        model.startsWith('deepseek-');
  }
}

final class _StreamingToolCall {
  String? id;
  String? name;
  final arguments = StringBuffer();

  void add(Map<String, Object?> fragment) {
    id ??= fragment['id'] as String?;
    final function = fragment['function'] as Map<String, Object?>?;
    name ??= function?['name'] as String?;
    final argumentFragment = function?['arguments'] as String?;
    if (argumentFragment != null) arguments.write(argumentFragment);
  }

  LlmToolCall toEvent() {
    final decoded = jsonDecode(arguments.toString());
    if (id == null || name == null || decoded is! Map<String, Object?>) {
      throw const FormatException('Invalid streamed tool call.');
    }
    return LlmToolCall(id: id!, name: name!, arguments: decoded);
  }
}
