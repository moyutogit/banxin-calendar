import 'package:banxin_calendar/features/assistant/domain/assistant_entities.dart';

abstract interface class AssistantRepository {
  Future<AiProviderConfig?> loadProviderConfig();

  Future<void> saveProviderConfig(AiProviderConfig config);

  Future<AssistantPersona> loadPersona();

  Future<void> savePersona(AssistantPersona persona);

  Future<Conversation> createConversation(Conversation conversation);

  Future<List<Conversation>> loadConversations();

  Future<List<AssistantMessage>> loadMessages(String conversationId);

  Future<void> saveMessage(AssistantMessage message);

  Future<AiAction?> loadAction(String id);

  Future<AiAction?> loadActionByIdempotencyKey(String key);

  Future<void> saveAction(AiAction action);
}
