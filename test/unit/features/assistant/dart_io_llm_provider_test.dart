import 'dart:async';
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
        'data: ${jsonEncode(<String, Object?>{
          'choices': <Object?>[
            <String, Object?>{
              'delta': <String, Object?>{'reasoning_content': 'checking '},
            },
          ],
        })}',
      );
      request.response.writeln(
        'data: ${jsonEncode(<String, Object?>{
          'choices': <Object?>[
            <String, Object?>{
              'delta': <String, Object?>{'content': 'done'},
            },
          ],
        })}',
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
            modelName: 'deepseek-v4-flash',
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
    expect(
      events.whereType<LlmReasoningDelta>().map((event) => event.text).join(),
      'checking ',
    );
    expect(
      events.whereType<LlmTextDelta>().map((event) => event.text).join(),
      'done',
    );
    expect(events.last, isA<LlmCompleted>());
  });

  test(
    'replays reasoning and tool messages and decodes a complete reply',
    () async {
      final requestBody = Completer<Map<String, Object?>>();
      final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
      addTearDown(() => server.close(force: true));
      server.listen((request) async {
        final body = jsonDecode(await utf8.decoder.bind(request).join());
        requestBody.complete(body as Map<String, Object?>);
        request.response.headers.contentType = ContentType.json;
        request.response.write(
          jsonEncode(<String, Object?>{
            'choices': <Object?>[
              <String, Object?>{
                'message': <String, Object?>{
                  'reasoning_content': 'final thought',
                  'content': 'final answer',
                },
              },
            ],
          }),
        );
        await request.response.close();
      });
      final provider = const DartIoLlmProvider();
      final events = await provider
          .chat(
            messages: const <LlmMessage>[
              LlmMessage(role: LlmRole.user, content: 'check alarms'),
              LlmMessage(
                role: LlmRole.assistant,
                content: '',
                reasoningContent: 'need local alarms',
                toolCalls: <LlmToolCall>[
                  LlmToolCall(
                    id: 'call-1',
                    name: 'get_alarm_summary',
                    arguments: <String, Object?>{},
                  ),
                ],
              ),
              LlmMessage(
                role: LlmRole.tool,
                content: '{"upcomingCount":1}',
                toolCallId: 'call-1',
              ),
            ],
            tools: const <ToolDefinition>[],
            config: AiProviderConfig(
              id: 'test',
              providerType: AiProviderType.openAiCompatible,
              baseUrl: Uri.parse('http://127.0.0.1:${server.port}/'),
              endpointPath: 'v1/chat/completions',
              modelName: 'deepseek-v4-flash',
              credentialRef: 'credential-ref',
              customHeadersRef: null,
              timeoutSeconds: 5,
              maxOutputTokens: 32,
              streamEnabled: false,
              connectionStatus: AiConnectionStatus.notTested,
            ),
            credential: 'test-only',
            customHeaders: const <String, String>{},
          )
          .toList();

      final body = await requestBody.future;
      final messages = body['messages']! as List<Object?>;
      final assistant = messages[1]! as Map<String, Object?>;
      final tool = messages[2]! as Map<String, Object?>;
      expect(assistant['reasoning_content'], 'need local alarms');
      expect(assistant['tool_calls'], isNotEmpty);
      expect(tool['tool_call_id'], 'call-1');
      expect(
        events.whereType<LlmReasoningDelta>().single.text,
        'final thought',
      );
      expect(events.whereType<LlmTextDelta>().single.text, 'final answer');
      expect(events.last, isA<LlmCompleted>());
    },
  );
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
