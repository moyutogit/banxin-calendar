import 'package:banxin_calendar/app/localization/generated/app_localizations.dart';
import 'package:banxin_calendar/app/theme/app_theme.dart';
import 'package:banxin_calendar/features/schedule/application/schedule_application_service.dart';
import 'package:banxin_calendar/features/schedule/application/schedule_providers.dart';
import 'package:banxin_calendar/features/schedule/domain/schedule_rules.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ScheduleRulesPage extends ConsumerStatefulWidget {
  const ScheduleRulesPage({super.key});

  @override
  ConsumerState<ScheduleRulesPage> createState() => _ScheduleRulesPageState();
}

class _ScheduleRulesPageState extends ConsumerState<ScheduleRulesPage> {
  late Future<ScheduleRulesView> _future;

  @override
  void initState() {
    super.initState();
    _reload();
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(strings.scheduleRulesTitle),
        actions: <Widget>[
          IconButton(
            tooltip: strings.shiftTemplatesTitle,
            onPressed: () => context.push('/schedule/shifts'),
            icon: const Icon(Icons.badge_outlined),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _create,
        icon: const Icon(Icons.add),
        label: Text(strings.newScheduleRule),
      ),
      body: SafeArea(
        child: FutureBuilder<ScheduleRulesView>(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(
                child: FilledButton.icon(
                  onPressed: () => setState(_reload),
                  icon: const Icon(Icons.refresh),
                  label: Text(strings.actionRetry),
                ),
              );
            }
            final rules = snapshot.requireData.rules;
            if (rules.isEmpty) {
              return _EmptyRules(onCreate: _create);
            }
            return ListView.separated(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.md,
                AppSpacing.md,
                AppSpacing.md,
                96,
              ),
              itemCount: rules.length,
              separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.sm),
              itemBuilder: (context, index) {
                final stored = rules[index];
                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.event_repeat_outlined),
                    title: Text(stored.rule.name),
                    subtitle: Text(
                      stored.enabled
                          ? strings.ruleEnabled
                          : strings.ruleDisabled,
                    ),
                    onTap: () => _edit(stored.rule),
                    trailing: SizedBox(
                      width: 112,
                      child: Row(
                        children: <Widget>[
                          Switch(
                            value: stored.enabled,
                            onChanged: (enabled) =>
                                _setEnabled(stored, enabled),
                          ),
                          PopupMenuButton<String>(
                            onSelected: (_) => _duplicate(stored.rule),
                            itemBuilder: (_) => <PopupMenuEntry<String>>[
                              PopupMenuItem<String>(
                                value: 'duplicate',
                                child: Text(strings.actionDuplicate),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  void _reload() {
    _future = ref.read(scheduleApplicationServiceProvider).loadRulesView();
  }

  Future<void> _create() async {
    final changed = await context.push<bool>('/schedule/setup');
    if (changed == true && mounted) {
      setState(_reload);
    }
  }

  Future<void> _edit(ScheduleRule rule) async {
    final service = ref.read(scheduleApplicationServiceProvider);
    final draft = service.draftForRule(rule);
    final changed = await context.push<bool>('/schedule/setup', extra: draft);
    if (changed == true && mounted) {
      setState(_reload);
    }
  }

  Future<void> _setEnabled(StoredScheduleRule stored, bool enabled) async {
    final service = ref.read(scheduleApplicationServiceProvider);
    await service.setRuleEnabled(stored.rule.id, enabled: enabled);
    if (mounted) {
      setState(_reload);
    }
  }

  Future<void> _duplicate(ScheduleRule rule) async {
    await ref.read(scheduleApplicationServiceProvider).duplicateRule(rule);
    if (mounted) {
      setState(_reload);
    }
  }
}

final class _EmptyRules extends StatelessWidget {
  const _EmptyRules({required this.onCreate});

  final VoidCallback onCreate;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.md),
      children: <Widget>[
        Card(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(
                  Icons.event_repeat_outlined,
                  size: 40,
                  color: colorScheme.primary,
                ),
                const SizedBox(height: AppSpacing.md),
                Text(
                  strings.scheduleRulesEmptyTitle,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(strings.scheduleRulesEmptyDescription),
                const SizedBox(height: AppSpacing.lg),
                FilledButton.icon(
                  onPressed: onCreate,
                  icon: const Icon(Icons.add),
                  label: Text(strings.newScheduleRule),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
