import 'package:banxin_calendar/features/assistant/domain/assistant_entities.dart';

abstract interface class AssistantRepository {
  Future<AiProviderConfig?> loadProviderConfig();

  Future<void> saveProviderConfig(AiProviderConfig config);

  Future<AssistantPersona> loadPersona();

  Future<void> savePersona(AssistantPersona persona);

  Future<Conversation> createConversation(
    Conversation conversation, {
    AssistantMessage? initialMessage,
  });

  Future<List<Conversation>> loadConversations();

  Future<List<AssistantMessage>> loadMessages(String conversationId);

  Future<void> saveMessage(AssistantMessage message);

  Future<void> updateConversationTitle(String id, String title);

  Future<List<AssistantMemory>> loadMemories({String? query});

  Future<void> saveMemory(AssistantMemory memory);

  Future<void> deleteMemory(String id, DateTime deletedAtUtc);

  Future<AiAction?> loadAction(String id);

  Future<AiAction?> loadActionByIdempotencyKey(String key);

  Future<void> saveAction(AiAction action);
}
