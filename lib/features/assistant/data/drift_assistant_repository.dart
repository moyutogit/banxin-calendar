import 'package:banxin_calendar/core/database/app_database.dart' as database;
import 'package:banxin_calendar/core/time/app_clock.dart';
import 'package:banxin_calendar/features/assistant/domain/assistant_entities.dart';
import 'package:banxin_calendar/features/assistant/domain/assistant_repository.dart';
import 'package:drift/drift.dart';

final class DriftAssistantRepository implements AssistantRepository {
  const DriftAssistantRepository(
    this._database, {
    this._clock = const SystemAppClock(),
  });

  final database.AppDatabase _database;
  final AppClock _clock;

  int get _now => _clock.nowUtc().millisecondsSinceEpoch;

  @override
  Future<AiProviderConfig?> loadProviderConfig() async {
    final row =
        await (_database.select(_database.aiProviderConfigs)
              ..orderBy(
                <OrderingTerm Function(database.$AiProviderConfigsTable)>[
                  (table) => OrderingTerm.desc(table.updatedAt),
                ],
              )
              ..limit(1))
            .getSingleOrNull();
    return row == null ? null : _mapConfig(row);
  }

  @override
  Future<void> saveProviderConfig(AiProviderConfig config) async {
    final existing = await (_database.select(
      _database.aiProviderConfigs,
    )..where((table) => table.id.equals(config.id))).getSingleOrNull();
    final now = _now;
    await _database
        .into(_database.aiProviderConfigs)
        .insertOnConflictUpdate(
          database.AiProviderConfigsCompanion.insert(
            id: config.id,
            providerType: config.providerType.name,
            baseUrl: config.baseUrl.toString(),
            endpointPath: config.endpointPath,
            modelName: config.modelName,
            credentialRef: config.credentialRef,
            customHeadersRef: Value<String?>(config.customHeadersRef),
            timeoutSeconds: config.timeoutSeconds,
            maxOutputTokens: config.maxOutputTokens,
            streamEnabled: config.streamEnabled ? 1 : 0,
            connectionStatus: config.connectionStatus.name,
            lastTestedAt: Value<int?>(
              config.lastTestedAtUtc?.millisecondsSinceEpoch,
            ),
            createdAt: existing?.createdAt ?? now,
            updatedAt: now,
          ),
        );
  }

  @override
  Future<AssistantPersona> loadPersona() async {
    final row = await (_database.select(
      _database.assistantPersonas,
    )..limit(1)).getSingleOrNull();
    if (row == null) {
      return const AssistantPersona(
        id: 'local-persona',
        displayName: '小班',
        preset: AssistantPersonaPreset.gentle,
        customInstruction: null,
        replyLength: AssistantReplyLength.medium,
        initiativeLevel: 1,
        emojiLevel: 1,
        avatarAssetId: 'default_gentle',
        scopes: AssistantDataScopes(),
      );
    }
    return AssistantPersona(
      id: row.id,
      displayName: row.displayName,
      preset: AssistantPersonaPreset.values.byName(row.presetType),
      customInstruction: row.customInstruction,
      replyLength: AssistantReplyLength.values.byName(row.replyLength),
      initiativeLevel: row.initiativeLevel,
      emojiLevel: row.emojiLevel,
      avatarAssetId: row.avatarAssetId,
      scopes: AssistantDataScopes(
        scheduleRead: row.scheduleRead == 1,
        attendanceRead: row.attendanceRead == 1,
        wageRead: row.wageRead == 1,
        alarmRead: row.alarmRead == 1,
        notesRead: row.notesRead == 1,
      ),
    );
  }

  @override
  Future<void> savePersona(AssistantPersona persona) {
    return _database
        .into(_database.assistantPersonas)
        .insertOnConflictUpdate(
          database.AssistantPersonasCompanion.insert(
            id: persona.id,
            displayName: persona.displayName,
            presetType: persona.preset.name,
            customInstruction: Value<String?>(persona.customInstruction),
            replyLength: persona.replyLength.name,
            initiativeLevel: persona.initiativeLevel,
            emojiLevel: persona.emojiLevel,
            avatarAssetId: persona.avatarAssetId,
            scheduleRead: persona.scopes.scheduleRead ? 1 : 0,
            attendanceRead: persona.scopes.attendanceRead ? 1 : 0,
            wageRead: persona.scopes.wageRead ? 1 : 0,
            alarmRead: persona.scopes.alarmRead ? 1 : 0,
            notesRead: persona.scopes.notesRead ? 1 : 0,
            updatedAt: _now,
          ),
        );
  }

  @override
  Future<Conversation> createConversation(Conversation conversation) async {
    await _database
        .into(_database.conversations)
        .insert(
          database.ConversationsCompanion.insert(
            id: conversation.id,
            title: conversation.title,
            modelSnapshotJson: conversation.modelSnapshotJson,
            createdAt: conversation.createdAtUtc.millisecondsSinceEpoch,
            updatedAt: conversation.updatedAtUtc.millisecondsSinceEpoch,
          ),
        );
    return conversation;
  }

  @override
  Future<List<Conversation>> loadConversations() async {
    final rows =
        await (_database.select(_database.conversations)
              ..where((table) => table.archivedAt.isNull())
              ..orderBy(<OrderingTerm Function(database.$ConversationsTable)>[
                (table) => OrderingTerm.desc(table.updatedAt),
              ]))
            .get();
    return List<Conversation>.unmodifiable(rows.map(_mapConversation));
  }

  @override
  Future<List<AssistantMessage>> loadMessages(String conversationId) async {
    final rows =
        await (_database.select(_database.messages)
              ..where((table) => table.conversationId.equals(conversationId))
              ..orderBy(<OrderingTerm Function(database.$MessagesTable)>[
                (table) => OrderingTerm.asc(table.createdAt),
              ]))
            .get();
    return List<AssistantMessage>.unmodifiable(rows.map(_mapMessage));
  }

  @override
  Future<void> saveMessage(AssistantMessage message) async {
    await _database.transaction(() async {
      await _database
          .into(_database.messages)
          .insert(
            database.MessagesCompanion.insert(
              id: message.id,
              conversationId: message.conversationId,
              role: message.role.name,
              content: message.content,
              reasoningContent: Value<String?>(message.reasoningContent),
              contentType: message.contentType,
              toolCallId: Value<String?>(message.toolCallId),
              localOnly: message.localOnly ? 1 : 0,
              createdAt: message.createdAtUtc.millisecondsSinceEpoch,
            ),
          );
      await (_database.update(
        _database.conversations,
      )..where((table) => table.id.equals(message.conversationId))).write(
        database.ConversationsCompanion(
          updatedAt: Value<int>(message.createdAtUtc.millisecondsSinceEpoch),
        ),
      );
    });
  }

  @override
  Future<AiAction?> loadAction(String id) async {
    final row = await (_database.select(
      _database.aiActions,
    )..where((table) => table.id.equals(id))).getSingleOrNull();
    return row == null ? null : _mapAction(row);
  }

  @override
  Future<AiAction?> loadActionByIdempotencyKey(String key) async {
    final row = await (_database.select(
      _database.aiActions,
    )..where((table) => table.idempotencyKey.equals(key))).getSingleOrNull();
    return row == null ? null : _mapAction(row);
  }

  @override
  Future<void> saveAction(AiAction action) {
    return _database
        .into(_database.aiActions)
        .insertOnConflictUpdate(
          database.AiActionsCompanion.insert(
            id: action.id,
            conversationId: action.conversationId,
            actionType: action.actionType,
            toolName: action.toolName,
            proposedPayloadJson: action.proposedPayloadJson,
            validatedPayloadJson: action.validatedPayloadJson,
            beforeSnapshotJson: action.beforeSnapshotJson,
            afterSnapshotJson: Value<String?>(action.afterSnapshotJson),
            status: action.status.name,
            confirmationTokenHash: action.confirmationTokenHash,
            idempotencyKey: action.idempotencyKey,
            inputVersion: action.inputVersion,
            expiresAt: action.expiresAtUtc.millisecondsSinceEpoch,
            confirmedAt: Value<int?>(
              action.confirmedAtUtc?.millisecondsSinceEpoch,
            ),
            executedAt: Value<int?>(
              action.executedAtUtc?.millisecondsSinceEpoch,
            ),
            undoneAt: Value<int?>(action.undoneAtUtc?.millisecondsSinceEpoch),
            errorCode: Value<String?>(action.errorCode),
            createdAt: action.createdAtUtc.millisecondsSinceEpoch,
          ),
        );
  }

  AiProviderConfig _mapConfig(
    database.AiProviderConfig row,
  ) => AiProviderConfig(
    id: row.id,
    providerType: AiProviderType.values.byName(row.providerType),
    baseUrl: Uri.parse(row.baseUrl),
    endpointPath: row.endpointPath,
    modelName: row.modelName,
    credentialRef: row.credentialRef,
    customHeadersRef: row.customHeadersRef,
    timeoutSeconds: row.timeoutSeconds,
    maxOutputTokens: row.maxOutputTokens,
    streamEnabled: row.streamEnabled == 1,
    connectionStatus: AiConnectionStatus.values.byName(row.connectionStatus),
    lastTestedAtUtc: row.lastTestedAt == null
        ? null
        : DateTime.fromMillisecondsSinceEpoch(row.lastTestedAt!, isUtc: true),
  );

  Conversation _mapConversation(database.Conversation row) => Conversation(
    id: row.id,
    title: row.title,
    modelSnapshotJson: row.modelSnapshotJson,
    createdAtUtc: DateTime.fromMillisecondsSinceEpoch(
      row.createdAt,
      isUtc: true,
    ),
    updatedAtUtc: DateTime.fromMillisecondsSinceEpoch(
      row.updatedAt,
      isUtc: true,
    ),
  );

  AssistantMessage _mapMessage(database.Message row) => AssistantMessage(
    id: row.id,
    conversationId: row.conversationId,
    role: LlmRole.values.byName(row.role),
    content: row.content,
    reasoningContent: row.reasoningContent,
    contentType: row.contentType,
    toolCallId: row.toolCallId,
    localOnly: row.localOnly == 1,
    createdAtUtc: DateTime.fromMillisecondsSinceEpoch(
      row.createdAt,
      isUtc: true,
    ),
  );

  AiAction _mapAction(database.AiAction row) => AiAction(
    id: row.id,
    conversationId: row.conversationId,
    actionType: row.actionType,
    toolName: row.toolName,
    proposedPayloadJson: row.proposedPayloadJson,
    validatedPayloadJson: row.validatedPayloadJson,
    beforeSnapshotJson: row.beforeSnapshotJson,
    afterSnapshotJson: row.afterSnapshotJson,
    status: AiActionStatus.values.byName(row.status),
    confirmationTokenHash: row.confirmationTokenHash,
    idempotencyKey: row.idempotencyKey,
    inputVersion: row.inputVersion,
    expiresAtUtc: DateTime.fromMillisecondsSinceEpoch(
      row.expiresAt,
      isUtc: true,
    ),
    confirmedAtUtc: row.confirmedAt == null
        ? null
        : DateTime.fromMillisecondsSinceEpoch(row.confirmedAt!, isUtc: true),
    executedAtUtc: row.executedAt == null
        ? null
        : DateTime.fromMillisecondsSinceEpoch(row.executedAt!, isUtc: true),
    undoneAtUtc: row.undoneAt == null
        ? null
        : DateTime.fromMillisecondsSinceEpoch(row.undoneAt!, isUtc: true),
    errorCode: row.errorCode,
    createdAtUtc: DateTime.fromMillisecondsSinceEpoch(
      row.createdAt,
      isUtc: true,
    ),
  );
}
