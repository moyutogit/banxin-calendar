import 'dart:convert';
import 'dart:io';

import 'package:banxin_calendar/features/assistant/data/dart_io_llm_provider.dart';
import 'package:banxin_calendar/features/assistant/domain/assistant_entities.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('assembles streamed OpenAI-compatible tool call fragments', () async {
    final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
    addTearDown(() => server.close(force: true));
    server.listen((request) async {
      await utf8.decoder.bind(request).join();
      request.response.headers.contentType = ContentType(
        'text',
        'event-stream',
        charset: 'utf-8',
      );
      request.response.writeln(
        'data: ${jsonEncode(_chunk(id: 'call-1', name: 'get_alarm_summary', arguments: '{'))}',
      );
      request.response.writeln('data: ${jsonEncode(_chunk(arguments: '}'))}');
      request.response.writeln('data: [DONE]');
      await request.response.close();
    });
    final provider = const DartIoLlmProvider();
    final events = await provider
        .chat(
          messages: const <LlmMessage>[
            LlmMessage(role: LlmRole.user, content: 'check alarms'),
          ],
          tools: const <ToolDefinition>[
            ToolDefinition(
              name: 'get_alarm_summary',
              description: 'test',
              parametersSchema: <String, Object?>{'type': 'object'},
            ),
          ],
          config: AiProviderConfig(
            id: 'test',
            providerType: AiProviderType.openAiCompatible,
            baseUrl: Uri.parse('http://127.0.0.1:${server.port}/'),
            endpointPath: 'v1/chat/completions',
            modelName: 'test-model',
            credentialRef: 'credential-ref',
            customHeadersRef: null,
            timeoutSeconds: 5,
            maxOutputTokens: 32,
            streamEnabled: true,
            connectionStatus: AiConnectionStatus.notTested,
          ),
          credential: 'test-only',
          customHeaders: const <String, String>{},
        )
        .toList();

    final call = events.whereType<LlmToolCall>().single;
    expect(call.id, 'call-1');
    expect(call.name, 'get_alarm_summary');
    expect(call.arguments, isEmpty);
    expect(events.last, isA<LlmCompleted>());
  });
}

Map<String, Object?> _chunk({
  String? id,
  String? name,
  String? arguments,
}) => <String, Object?>{
  'choices': <Object?>[
    <String, Object?>{
      'delta': <String, Object?>{
        'tool_calls': <Object?>[
          <String, Object?>{
            'index': 0,
            'id': id,
            'function': <String, Object?>{'name': name, 'arguments': arguments},
          },
        ],
      },
    },
  ],
};
