import 'package:banxin_calendar/core/ids/stable_id_generator.dart';
import 'package:banxin_calendar/core/time/app_clock.dart';
import 'package:banxin_calendar/features/assistant/domain/assistant_entities.dart';
import 'package:banxin_calendar/features/assistant/domain/assistant_repository.dart';
import 'package:banxin_calendar/features/schedule/domain/value_objects.dart';

final class AssistantAgentService {
  AssistantAgentService(
    this._repository, {
    this.clock = const SystemAppClock(),
    StableIdGenerator? idGenerator,
  }) : _idGenerator = idGenerator ?? UuidV4Generator();

  final AssistantRepository _repository;
  final AppClock clock;
  final StableIdGenerator _idGenerator;

  Map<String, Object?> timeContext() {
    final now = clock.nowUtc().add(const Duration(hours: 8));
    final today = LocalDate(now.year, now.month, now.day);
    return <String, Object?>{
      'timezone': 'Asia/Shanghai',
      'utcOffset': '+08:00',
      'localDateTime':
          '${today}T${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}+08:00',
      'weekday': today.weekday,
      'relativeDates': <String, Object?>{
        'yesterday': today.addDays(-1).toString(),
        'today': today.toString(),
        'tomorrow': today.addDays(1).toString(),
        'dayAfterTomorrow': today.addDays(2).toString(),
        'tomorrowThroughDayAfterTomorrow': <String, String>{
          'start': today.addDays(1).toString(),
          'end': today.addDays(2).toString(),
        },
      },
    };
  }

  Future<AssistantPersona> updateProfile({
    required AssistantPersona current,
    required String conversationId,
    required Map<String, Object?> arguments,
  }) async {
    final latestUserText = await _latestUserText(conversationId);
    if (!_profileIntent.hasMatch(latestUserText)) {
      throw const FormatException(
        'Only update the agent profile after the user explicitly states a name, personality, or response-style preference.',
      );
    }
    final displayName = _optionalString(arguments, 'display_name')?.trim();
    final presetName = _optionalString(arguments, 'persona');
    final replyLengthName = _optionalString(arguments, 'reply_length');
    final customInstruction = _optionalString(
      arguments,
      'custom_instruction',
    )?.trim();
    if (displayName != null &&
        (displayName.isEmpty || displayName.length > 30)) {
      throw const FormatException(
        'Agent name must contain 1 to 30 characters.',
      );
    }
    if (customInstruction != null && customInstruction.length > 200) {
      throw const FormatException('Style instruction exceeds 200 characters.');
    }
    final persona = AssistantPersona(
      id: current.id,
      displayName: displayName ?? current.displayName,
      preset: presetName == null
          ? current.preset
          : _enumValue(AssistantPersonaPreset.values, presetName, 'persona'),
      customInstruction: customInstruction ?? current.customInstruction,
      replyLength: replyLengthName == null
          ? current.replyLength
          : _enumValue(
              AssistantReplyLength.values,
              replyLengthName,
              'reply_length',
            ),
      initiativeLevel: current.initiativeLevel,
      emojiLevel: current.emojiLevel,
      avatarAssetId: current.avatarAssetId,
      scopes: current.scopes,
    );
    await _repository.savePersona(persona);
    return persona;
  }

  Future<List<AssistantMemory>> loadMemories({String? query}) {
    final safeQuery = query?.trim();
    if (safeQuery != null && safeQuery.length > 100) {
      throw const FormatException('Memory query exceeds 100 characters.');
    }
    return _repository.loadMemories(query: safeQuery);
  }

  Future<AssistantMemory> remember({
    required String conversationId,
    required Map<String, Object?> arguments,
  }) async {
    final latestUserText = await _latestUserText(conversationId);
    if (!_rememberIntent.hasMatch(latestUserText)) {
      throw const FormatException(
        'Memory can be saved only after an explicit user request to remember it.',
      );
    }
    final content = _requiredString(arguments, 'content').trim();
    if (content.isEmpty || content.length > 500) {
      throw const FormatException('Memory must contain 1 to 500 characters.');
    }
    final category = _enumValue(
      AssistantMemoryCategory.values,
      _requiredString(arguments, 'category'),
      'category',
    );
    final existing = await _repository.loadMemories();
    final duplicate = existing.where(
      (memory) => memory.content.toLowerCase() == content.toLowerCase(),
    );
    if (duplicate.isNotEmpty) return duplicate.first;
    final now = clock.nowUtc();
    final memory = AssistantMemory(
      id: _idGenerator.generate(),
      content: content,
      category: category,
      sourceConversationId: conversationId,
      createdAtUtc: now,
      updatedAtUtc: now,
    );
    await _repository.saveMemory(memory);
    return memory;
  }

  Future<void> forget({
    required String conversationId,
    required String memoryId,
  }) async {
    final latestUserText = await _latestUserText(conversationId);
    if (!_forgetIntent.hasMatch(latestUserText)) {
      throw const FormatException(
        'Memory can be deleted only after an explicit user request to forget it.',
      );
    }
    await _repository.deleteMemory(memoryId, clock.nowUtc());
  }

  Future<String> _latestUserText(String conversationId) async {
    final messages = await _repository.loadMessages(conversationId);
    return messages
            .where((message) => message.role == LlmRole.user)
            .lastOrNull
            ?.content ??
        '';
  }

  String _requiredString(Map<String, Object?> arguments, String key) {
    final value = arguments[key];
    if (value is! String) throw FormatException('$key is required.');
    return value;
  }

  String? _optionalString(Map<String, Object?> arguments, String key) {
    final value = arguments[key];
    if (value == null) return null;
    if (value is! String) throw FormatException('$key must be a string.');
    return value;
  }

  T _enumValue<T extends Enum>(List<T> values, String name, String key) {
    try {
      return values.byName(name);
    } on ArgumentError {
      throw FormatException('$key has an unsupported value.');
    }
  }

  static final RegExp _profileIntent = RegExp(
    r'叫你|名字|名称|性格|风格|语气|幽默|毒舌|吐槽|冷静|温柔|专业|活泼|精炼|简洁|啰嗦|详细|name|personality|style|tone',
    caseSensitive: false,
  );
  static final RegExp _rememberIntent = RegExp(
    r'记住|记一下|记得|保存.{0,4}记忆|remember|save.{0,8}memory',
    caseSensitive: false,
  );
  static final RegExp _forgetIntent = RegExp(
    r'忘记|删除.{0,4}记忆|不要再记|forget|delete.{0,8}memory',
    caseSensitive: false,
  );
}
