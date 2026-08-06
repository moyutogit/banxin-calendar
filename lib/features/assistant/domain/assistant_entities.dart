import 'package:banxin_calendar/features/schedule/domain/value_objects.dart';

enum AiProviderType { openAiCompatible, customRest }

enum AiConnectionStatus {
  notTested,
  connected,
  invalidUrl,
  networkFailure,
  tlsFailure,
  authenticationFailure,
  modelNotFound,
  rateLimited,
  insufficientBalance,
  incompatibleResponse,
  timeout,
}

enum LlmRole { system, user, assistant, tool }

enum AssistantPersonaPreset { gentle, professional, lively }

enum AssistantReplyLength { short, medium, long }

enum AiActionStatus {
  proposed,
  executing,
  succeeded,
  failed,
  expired,
  invalidated,
  undone,
}

final class AiProviderConfig {
  const AiProviderConfig({
    required this.id,
    required this.providerType,
    required this.baseUrl,
    required this.endpointPath,
    required this.modelName,
    required this.credentialRef,
    required this.customHeadersRef,
    required this.timeoutSeconds,
    required this.maxOutputTokens,
    required this.streamEnabled,
    required this.connectionStatus,
    this.lastTestedAtUtc,
  });

  final String id;
  final AiProviderType providerType;
  final Uri baseUrl;
  final String endpointPath;
  final String modelName;
  final String credentialRef;
  final String? customHeadersRef;
  final int timeoutSeconds;
  final int maxOutputTokens;
  final bool streamEnabled;
  final AiConnectionStatus connectionStatus;
  final DateTime? lastTestedAtUtc;

  Uri get endpoint => baseUrl.resolve(endpointPath);
}

final class AssistantDataScopes {
  const AssistantDataScopes({
    this.scheduleRead = true,
    this.attendanceRead = true,
    this.wageRead = false,
    this.alarmRead = true,
    this.notesRead = false,
  });

  final bool scheduleRead;
  final bool attendanceRead;
  final bool wageRead;
  final bool alarmRead;
  final bool notesRead;
}

final class AssistantPersona {
  const AssistantPersona({
    required this.id,
    required this.displayName,
    required this.preset,
    required this.customInstruction,
    required this.replyLength,
    required this.initiativeLevel,
    required this.emojiLevel,
    required this.avatarAssetId,
    required this.scopes,
  });

  final String id;
  final String displayName;
  final AssistantPersonaPreset preset;
  final String? customInstruction;
  final AssistantReplyLength replyLength;
  final int initiativeLevel;
  final int emojiLevel;
  final String avatarAssetId;
  final AssistantDataScopes scopes;
}

final class Conversation {
  const Conversation({
    required this.id,
    required this.title,
    required this.modelSnapshotJson,
    required this.createdAtUtc,
    required this.updatedAtUtc,
  });

  final String id;
  final String title;
  final String modelSnapshotJson;
  final DateTime createdAtUtc;
  final DateTime updatedAtUtc;
}

final class AssistantMessage {
  const AssistantMessage({
    required this.id,
    required this.conversationId,
    required this.role,
    required this.content,
    required this.contentType,
    required this.localOnly,
    required this.createdAtUtc,
    this.reasoningContent,
    this.toolCallId,
  });

  final String id;
  final String conversationId;
  final LlmRole role;
  final String content;
  final String? reasoningContent;
  final String contentType;
  final String? toolCallId;
  final bool localOnly;
  final DateTime createdAtUtc;
}

final class LlmMessage {
  const LlmMessage({
    required this.role,
    required this.content,
    this.reasoningContent,
    this.toolCalls = const <LlmToolCall>[],
    this.toolCallId,
  });

  final LlmRole role;
  final String content;
  final String? reasoningContent;
  final List<LlmToolCall> toolCalls;
  final String? toolCallId;
}

final class ToolDefinition {
  const ToolDefinition({
    required this.name,
    required this.description,
    required this.parametersSchema,
  });

  final String name;
  final String description;
  final Map<String, Object?> parametersSchema;
}

sealed class LlmEvent {
  const LlmEvent();
}

final class LlmTextDelta extends LlmEvent {
  const LlmTextDelta(this.text);

  final String text;
}

final class LlmReasoningDelta extends LlmEvent {
  const LlmReasoningDelta(this.text);

  final String text;
}

final class LlmToolCall extends LlmEvent {
  const LlmToolCall({
    required this.id,
    required this.name,
    required this.arguments,
  });

  final String id;
  final String name;
  final Map<String, Object?> arguments;
}

final class LlmCompleted extends LlmEvent {
  const LlmCompleted();
}

final class ConnectionTestResult {
  const ConnectionTestResult(this.status);

  final AiConnectionStatus status;

  bool get succeeded => status == AiConnectionStatus.connected;
}

final class ScheduleChangePayload {
  const ScheduleChangePayload({
    required this.range,
    required this.status,
    required this.shiftId,
    required this.syncAlarms,
  });

  final DateRange range;
  final String status;
  final ShiftId? shiftId;
  final bool syncAlarms;
}

final class AiAction {
  const AiAction({
    required this.id,
    required this.conversationId,
    required this.actionType,
    required this.toolName,
    required this.proposedPayloadJson,
    required this.validatedPayloadJson,
    required this.beforeSnapshotJson,
    required this.afterSnapshotJson,
    required this.status,
    required this.confirmationTokenHash,
    required this.idempotencyKey,
    required this.inputVersion,
    required this.expiresAtUtc,
    required this.createdAtUtc,
    this.confirmedAtUtc,
    this.executedAtUtc,
    this.undoneAtUtc,
    this.errorCode,
  });

  final String id;
  final String conversationId;
  final String actionType;
  final String toolName;
  final String proposedPayloadJson;
  final String validatedPayloadJson;
  final String beforeSnapshotJson;
  final String? afterSnapshotJson;
  final AiActionStatus status;
  final String confirmationTokenHash;
  final String idempotencyKey;
  final String inputVersion;
  final DateTime expiresAtUtc;
  final DateTime createdAtUtc;
  final DateTime? confirmedAtUtc;
  final DateTime? executedAtUtc;
  final DateTime? undoneAtUtc;
  final String? errorCode;
}

final class AiActionProposal {
  const AiActionProposal({
    required this.action,
    required this.confirmationToken,
    required this.summary,
  });

  final AiAction action;
  final String confirmationToken;
  final String summary;
}
