import 'dart:async';

import 'package:banxin_calendar/app/localization/generated/app_localizations.dart';
import 'package:banxin_calendar/core/presentation/app_message.dart';
import 'package:banxin_calendar/features/assistant/application/assistant_action_gateway.dart';
import 'package:banxin_calendar/features/assistant/application/assistant_providers.dart';
import 'package:banxin_calendar/features/assistant/application/conversation_service.dart';
import 'package:banxin_calendar/features/assistant/domain/assistant_entities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AssistantPage extends ConsumerStatefulWidget {
  const AssistantPage({super.key});

  @override
  ConsumerState<AssistantPage> createState() => _AssistantPageState();
}

class _AssistantPageState extends ConsumerState<AssistantPage> {
  final _input = TextEditingController();
  final _scroll = ScrollController();
  StreamSubscription<ConversationEvent>? _subscription;
  AssistantPersona? _persona;
  Conversation? _conversation;
  List<Conversation> _conversations = const <Conversation>[];
  List<AssistantMessage> _messages = const <AssistantMessage>[];
  String _partial = '';
  String _partialReasoning = '';
  String _queuedText = '';
  String _queuedReasoning = '';
  bool _streamUpdateScheduled = false;
  String? _error;
  String? _lastRequestText;
  String? _proposalActionId;
  String? _proposalToken;
  String? _proposalSummary;
  String? _undoActionId;
  bool _configured = false;
  bool _loading = true;
  bool _generating = false;

  @override
  void initState() {
    super.initState();
    unawaited(_initialize());
  }

  @override
  void dispose() {
    unawaited(_subscription?.cancel());
    _input.dispose();
    _scroll.dispose();
    super.dispose();
  }

  Future<void> _initialize() async {
    final settings = await ref.read(assistantSettingsServiceProvider).load();
    if (!mounted) return;
    if (settings.config == null) {
      setState(() {
        _persona = settings.persona;
        _loading = false;
        _configured = false;
      });
      return;
    }
    final conversation = await ref
        .read(conversationServiceProvider)
        .loadOrCreateConversation();
    final messages = await ref
        .read(conversationServiceProvider)
        .loadMessages(conversation.id);
    final conversations = await ref
        .read(conversationServiceProvider)
        .loadConversations();
    if (mounted) {
      setState(() {
        _persona = settings.persona;
        _conversation = conversation;
        _conversations = conversations;
        _messages = messages;
        _configured = true;
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    if (_loading) return const Center(child: CircularProgressIndicator());
    if (!_configured) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Icon(Icons.auto_awesome_outlined, size: 64),
              const SizedBox(height: 16),
              Text(strings.assistantNotConfigured, textAlign: TextAlign.center),
              const SizedBox(height: 16),
              FilledButton.icon(
                onPressed: () async {
                  await context.push('/settings/assistant');
                  if (mounted) unawaited(_initialize());
                },
                icon: const Icon(Icons.settings_outlined),
                label: Text(strings.assistantConfigureTitle),
              ),
            ],
          ),
        ),
      );
    }
    return Column(
      children: <Widget>[
        Material(
          elevation: 1,
          child: SafeArea(
            bottom: false,
            child: ListTile(
              leading: CircleAvatar(
                child: Text((_persona?.displayName ?? 'AI').characters.first),
              ),
              title: Text(_persona?.displayName ?? strings.tabAssistant),
              subtitle: Text(
                '${_conversation?.title ?? ''} · ${_persona?.preset.name ?? ''}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  IconButton(
                    tooltip: strings.assistantConversations,
                    onPressed: _generating ? null : _openConversationList,
                    icon: const Icon(Icons.forum_outlined),
                  ),
                  IconButton(
                    tooltip: strings.assistantNewConversation,
                    onPressed: _generating ? null : _newConversation,
                    icon: const Icon(Icons.add_comment_outlined),
                  ),
                  IconButton(
                    tooltip: strings.assistantConfigureTitle,
                    onPressed: () async {
                      await context.push('/settings/assistant');
                      if (mounted) unawaited(_initialize());
                    },
                    icon: const Icon(Icons.settings_outlined),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView(
            controller: _scroll,
            padding: const EdgeInsets.all(12),
            children: <Widget>[
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: <Widget>[
                  _quick(
                    strings.assistantQuickAttendance,
                    enabled: _persona?.scopes.attendanceRead ?? false,
                  ),
                  _quick(
                    strings.assistantQuickSchedule,
                    enabled: _persona?.scopes.scheduleRead ?? false,
                  ),
                  _quick(
                    strings.assistantQuickWage,
                    enabled:
                        (_persona?.scopes.attendanceRead ?? false) &&
                        (_persona?.scopes.wageRead ?? false),
                  ),
                  _quick(
                    strings.assistantQuickAlarm,
                    enabled: _persona?.scopes.alarmRead ?? false,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              if (_messages.isEmpty && !_generating)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 32),
                  child: Text(
                    strings.assistantEmptyConversation,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ..._messages.map(_messageBubble),
              if (_generating ||
                  _partial.isNotEmpty ||
                  _partialReasoning.isNotEmpty)
                _assistantBubble(
                  text: _partial,
                  reasoning: _partialReasoning,
                  streaming: _generating,
                ),
              if (_proposalActionId != null) _proposalCard(strings),
              if (_undoActionId != null)
                Card(
                  child: ListTile(
                    title: Text(strings.assistantActionSucceeded),
                    trailing: TextButton(
                      onPressed: _undo,
                      child: Text(strings.assistantActionUndo),
                    ),
                  ),
                ),
              if (_error != null)
                Card(
                  color: Theme.of(context).colorScheme.errorContainer,
                  child: ListTile(
                    leading: const Icon(Icons.error_outline),
                    title: Text(_error!),
                    trailing: IconButton(
                      tooltip: strings.actionRetry,
                      onPressed: _generating ? null : _retry,
                      icon: const Icon(Icons.refresh),
                    ),
                  ),
                ),
            ],
          ),
        ),
        SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 4, 12, 12),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _input,
                    minLines: 1,
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: strings.assistantInputHint,
                      border: const OutlineInputBorder(),
                    ),
                    onSubmitted: (_) {
                      if (!_generating) _send();
                    },
                  ),
                ),
                const SizedBox(width: 8),
                IconButton.filled(
                  tooltip: _generating
                      ? strings.assistantStop
                      : strings.assistantSend,
                  onPressed: _generating ? _stop : _send,
                  icon: Icon(_generating ? Icons.stop : Icons.send),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _quick(String text, {required bool enabled}) => ActionChip(
    avatar: enabled ? null : const Icon(Icons.lock_outline, size: 18),
    label: Text(text),
    onPressed: _generating
        ? null
        : () {
            if (!enabled) {
              AppMessage.show(
                context,
                AppLocalizations.of(context).assistantQuickPermissionRequired,
                type: AppMessageType.warning,
              );
              return;
            }
            _startSending(text);
          },
  );

  Widget _messageBubble(AssistantMessage message) {
    if (message.role == LlmRole.user) {
      return _bubble(message.content, isUser: true);
    }
    return _assistantBubble(
      key: ValueKey<String>(message.id),
      text: message.content,
      reasoning: message.reasoningContent ?? '',
    );
  }

  Widget _bubble(String text, {required bool isUser}) => Align(
    alignment: isUser
        ? AlignmentDirectional.centerEnd
        : AlignmentDirectional.centerStart,
    child: Container(
      constraints: const BoxConstraints(maxWidth: 520),
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isUser
            ? Theme.of(context).colorScheme.primaryContainer
            : Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
      ),
      child: SelectableText(text),
    ),
  );

  Widget _assistantBubble({
    Key? key,
    required String text,
    required String reasoning,
    bool streaming = false,
  }) {
    final strings = AppLocalizations.of(context);
    return Align(
      key: key,
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 520),
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (reasoning.isNotEmpty)
              _ReasoningPanel(
                text: reasoning,
                title: streaming
                    ? strings.assistantThinkingInProgress
                    : strings.assistantThinking,
                initiallyExpanded: streaming,
              ),
            if (reasoning.isNotEmpty && text.isNotEmpty)
              const SizedBox(height: 10),
            if (text.isNotEmpty)
              SelectableText(text)
            else if (streaming && reasoning.isEmpty)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const SizedBox.square(
                    dimension: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                  const SizedBox(width: 10),
                  Text(strings.assistantPreparingResponse),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _proposalCard(AppLocalizations strings) => Card(
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            strings.assistantProposalTitle,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(_proposalSummary ?? ''),
          const SizedBox(height: 12),
          Row(
            children: <Widget>[
              Expanded(
                child: OutlinedButton(
                  onPressed: _cancelProposal,
                  child: Text(strings.assistantProposalCancel),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: FilledButton(
                  onPressed: _confirmProposal,
                  child: Text(strings.assistantProposalConfirm),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );

  void _send() => _startSending(_input.text);

  void _startSending(
    String rawText, {
    bool saveUserMessage = true,
    bool showOptimisticMessage = true,
  }) {
    final conversation = _conversation;
    final text = rawText.trim();
    if (conversation == null || text.isEmpty || _generating) {
      return;
    }
    final optimisticMessage = AssistantMessage(
      id: 'optimistic-${DateTime.now().microsecondsSinceEpoch}',
      conversationId: conversation.id,
      role: LlmRole.user,
      content: text,
      contentType: 'text',
      localOnly: false,
      createdAtUtc: DateTime.now().toUtc(),
    );
    _input.clear();
    setState(() {
      _generating = true;
      _partial = '';
      _partialReasoning = '';
      _queuedText = '';
      _queuedReasoning = '';
      _error = null;
      _lastRequestText = text;
      if (showOptimisticMessage) {
        _messages = <AssistantMessage>[..._messages, optimisticMessage];
      }
      _proposalActionId = null;
      _proposalToken = null;
      _proposalSummary = null;
    });
    _scrollToBottom();
    _subscription = ref
        .read(conversationServiceProvider)
        .send(
          conversationId: conversation.id,
          userText: text,
          saveUserMessage: saveUserMessage,
        )
        .listen(
          (event) {
            if (!mounted) return;
            switch (event) {
              case ConversationTextDelta():
                _queueStreamUpdate(text: event.text);
              case ConversationReasoningDelta():
                _queueStreamUpdate(reasoning: event.text);
              case ConversationProposal():
                setState(() {
                  _proposalActionId = event.actionId;
                  _proposalToken = event.confirmationToken;
                  _proposalSummary = event.summary;
                });
              case ConversationFinished():
                unawaited(_finish(success: true));
            }
          },
          onError: (Object error) {
            if (mounted) {
              final strings = AppLocalizations.of(context);
              setState(() {
                _generating = false;
                _error = strings.assistantRequestFailed;
              });
              AppMessage.show(
                context,
                strings.assistantRequestFailed,
                type: AppMessageType.error,
              );
            }
          },
        );
  }

  void _retry() {
    final text = _lastRequestText;
    if (text == null) return;
    _startSending(text, saveUserMessage: false, showOptimisticMessage: false);
  }

  void _queueStreamUpdate({String text = '', String reasoning = ''}) {
    _queuedText += text;
    _queuedReasoning += reasoning;
    if (_streamUpdateScheduled) return;
    _streamUpdateScheduled = true;
    WidgetsBinding.instance.scheduleFrameCallback((_) {
      if (!mounted) return;
      setState(() {
        _partial += _queuedText;
        _partialReasoning += _queuedReasoning;
        _queuedText = '';
        _queuedReasoning = '';
        _streamUpdateScheduled = false;
      });
      _scrollToBottom();
    });
  }

  Future<void> _finish({required bool success}) async {
    final conversation = _conversation;
    if (conversation == null) return;
    final messages = await ref
        .read(conversationServiceProvider)
        .loadMessages(conversation.id);
    final settings = await ref.read(assistantSettingsServiceProvider).load();
    final conversations = await ref
        .read(conversationServiceProvider)
        .loadConversations();
    final refreshedConversation = conversations
        .where((item) => item.id == conversation.id)
        .firstOrNull;
    if (mounted) {
      setState(() {
        _messages = messages;
        _persona = settings.persona;
        _conversations = conversations;
        _conversation = refreshedConversation ?? conversation;
        _partial = '';
        _partialReasoning = '';
        _queuedText = '';
        _queuedReasoning = '';
        _generating = false;
        if (success) {
          _lastRequestText = null;
          _error = null;
        }
      });
      _scrollToBottom();
    }
  }

  Future<void> _openConversationList() async {
    final strings = AppLocalizations.of(context);
    final selected = await showModalBottomSheet<String>(
      context: context,
      showDragHandle: true,
      builder: (sheetContext) => SafeArea(
        child: SizedBox(
          height: MediaQuery.sizeOf(sheetContext).height * 0.65,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 12, 8),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        strings.assistantConversations,
                        style: Theme.of(sheetContext).textTheme.titleLarge,
                      ),
                    ),
                    IconButton.filledTonal(
                      tooltip: strings.assistantNewConversation,
                      onPressed: () => Navigator.pop(sheetContext, '__new__'),
                      icon: const Icon(Icons.add),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),
              Expanded(
                child: ListView.builder(
                  itemCount: _conversations.length,
                  itemBuilder: (context, index) {
                    final conversation = _conversations[index];
                    final selected = conversation.id == _conversation?.id;
                    return ListTile(
                      leading: Icon(
                        selected
                            ? Icons.chat_bubble
                            : Icons.chat_bubble_outline,
                      ),
                      title: Text(
                        conversation.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(_conversationTimestamp(conversation)),
                      trailing: selected
                          ? Tooltip(
                              message: strings.assistantCurrentConversation,
                              child: const Icon(Icons.check_circle_outline),
                            )
                          : null,
                      onTap: () => Navigator.pop(context, conversation.id),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
    if (!mounted || selected == null) return;
    if (selected == '__new__') {
      await _newConversation();
    } else if (selected != _conversation?.id) {
      await _switchConversation(selected);
    }
  }

  Future<void> _newConversation() async {
    if (_generating) return;
    final service = ref.read(conversationServiceProvider);
    final conversation = await service.createConversation();
    final conversations = await service.loadConversations();
    if (!mounted) return;
    setState(() {
      _conversation = conversation;
      _conversations = conversations;
      _messages = const <AssistantMessage>[];
      _partial = '';
      _partialReasoning = '';
      _error = null;
      _lastRequestText = null;
      _proposalActionId = null;
      _proposalToken = null;
      _proposalSummary = null;
      _undoActionId = null;
    });
  }

  Future<void> _switchConversation(String id) async {
    if (_generating) return;
    final conversation = _conversations.firstWhere((item) => item.id == id);
    final messages = await ref
        .read(conversationServiceProvider)
        .loadMessages(id);
    if (!mounted) return;
    setState(() {
      _conversation = conversation;
      _messages = messages;
      _partial = '';
      _partialReasoning = '';
      _error = null;
      _lastRequestText = null;
      _proposalActionId = null;
      _proposalToken = null;
      _proposalSummary = null;
      _undoActionId = null;
    });
    _scrollToBottom();
  }

  String _conversationTimestamp(Conversation conversation) {
    final value = conversation.updatedAtUtc.toLocal();
    String two(int number) => number.toString().padLeft(2, '0');
    return '${value.year}-${two(value.month)}-${two(value.day)} '
        '${two(value.hour)}:${two(value.minute)}';
  }

  Future<void> _stop() async {
    await _subscription?.cancel();
    if (mounted) {
      setState(() {
        _generating = false;
        _queuedText = '';
        _queuedReasoning = '';
      });
    }
  }

  void _cancelProposal() {
    setState(() {
      _proposalActionId = null;
      _proposalToken = null;
      _proposalSummary = null;
    });
  }

  Future<void> _confirmProposal() async {
    final actionId = _proposalActionId;
    final token = _proposalToken;
    if (actionId == null || token == null) return;
    try {
      await ref
          .read(assistantActionGatewayProvider)
          .confirmAction(actionId: actionId, confirmationToken: token);
      if (mounted) {
        setState(() {
          _undoActionId = actionId;
          _proposalActionId = null;
          _proposalToken = null;
          _proposalSummary = null;
        });
      }
    } on AssistantActionException catch (error) {
      if (mounted) setState(() => _error = error.code);
    }
  }

  Future<void> _undo() async {
    final actionId = _undoActionId;
    if (actionId == null) return;
    await ref.read(assistantActionGatewayProvider).undoAction(actionId);
    if (mounted) {
      setState(() {
        _undoActionId = null;
        _error = AppLocalizations.of(context).assistantActionUndone;
      });
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scroll.hasClients) {
        unawaited(
          _scroll.animateTo(
            _scroll.position.maxScrollExtent,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
          ),
        );
      }
    });
  }
}

class _ReasoningPanel extends StatefulWidget {
  const _ReasoningPanel({
    required this.text,
    required this.title,
    required this.initiallyExpanded,
  });

  final String text;
  final String title;
  final bool initiallyExpanded;

  @override
  State<_ReasoningPanel> createState() => _ReasoningPanelState();
}

class _ReasoningPanelState extends State<_ReasoningPanel> {
  late bool _expanded = widget.initiallyExpanded;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surfaceContainer,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colors.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () => setState(() => _expanded = !_expanded),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.psychology_outlined,
                    size: 18,
                    color: colors.primary,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      widget.title,
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ),
                  Icon(_expanded ? Icons.expand_less : Icons.expand_more),
                ],
              ),
            ),
          ),
          AnimatedCrossFade(
            firstChild: const SizedBox(width: double.infinity),
            secondChild: Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: SelectableText(
                widget.text,
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: colors.onSurfaceVariant),
              ),
            ),
            crossFadeState: _expanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 180),
          ),
        ],
      ),
    );
  }
}
