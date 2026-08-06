import 'dart:async';

import 'package:banxin_calendar/app/localization/generated/app_localizations.dart';
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
  List<AssistantMessage> _messages = const <AssistantMessage>[];
  String _partial = '';
  String? _error;
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
    if (mounted) {
      setState(() {
        _persona = settings.persona;
        _conversation = conversation;
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
              subtitle: Text(_persona?.preset.name ?? ''),
              trailing: IconButton(
                tooltip: strings.assistantConfigureTitle,
                onPressed: () => context.push('/settings/assistant'),
                icon: const Icon(Icons.settings_outlined),
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
                  _quick(strings.assistantQuickAttendance),
                  _quick(strings.assistantQuickSchedule),
                  _quick(strings.assistantQuickWage),
                  _quick(strings.assistantQuickAlarm),
                ],
              ),
              const SizedBox(height: 12),
              ..._messages.map(_messageBubble),
              if (_partial.isNotEmpty) _bubble(_partial, isUser: false),
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
                      onPressed: _generating ? null : _send,
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
                    onSubmitted: (_) => _generating ? null : _send(),
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

  Widget _quick(String text) => ActionChip(
    label: Text(text),
    onPressed: _generating
        ? null
        : () {
            _input.text = text;
            _send();
          },
  );

  Widget _messageBubble(AssistantMessage message) =>
      _bubble(message.content, isUser: message.role == LlmRole.user);

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

  void _send() {
    final conversation = _conversation;
    if (conversation == null || _input.text.trim().isEmpty || _generating) {
      return;
    }
    setState(() {
      _generating = true;
      _partial = '';
      _error = null;
      _proposalActionId = null;
      _proposalToken = null;
      _proposalSummary = null;
    });
    _subscription = ref
        .read(conversationServiceProvider)
        .send(conversationId: conversation.id, userText: _input.text)
        .listen(
          (event) {
            if (!mounted) return;
            switch (event) {
              case ConversationTextDelta():
                setState(() => _partial += event.text);
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
              setState(() {
                _generating = false;
                _error = error.toString();
              });
            }
          },
        );
  }

  Future<void> _finish({required bool success}) async {
    final conversation = _conversation;
    if (conversation == null) return;
    final messages = await ref
        .read(conversationServiceProvider)
        .loadMessages(conversation.id);
    if (mounted) {
      setState(() {
        _messages = messages;
        _partial = '';
        _generating = false;
        if (success) _input.clear();
      });
      _scrollToBottom();
    }
  }

  Future<void> _stop() async {
    await _subscription?.cancel();
    if (mounted) setState(() => _generating = false);
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
          .confirmScheduleChange(actionId: actionId, confirmationToken: token);
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
    await ref.read(assistantActionGatewayProvider).undoScheduleChange(actionId);
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
