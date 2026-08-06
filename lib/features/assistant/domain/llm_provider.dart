import 'package:banxin_calendar/features/assistant/domain/assistant_entities.dart';

abstract interface class LlmProvider {
  Stream<LlmEvent> chat({
    required List<LlmMessage> messages,
    required List<ToolDefinition> tools,
    required AiProviderConfig config,
    required String credential,
    required Map<String, String> customHeaders,
  });

  Future<ConnectionTestResult> testConnection({
    required AiProviderConfig config,
    required String credential,
    required Map<String, String> customHeaders,
  });
}
