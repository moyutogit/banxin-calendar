import 'package:banxin_calendar/app/localization/generated/app_localizations.dart';
import 'package:banxin_calendar/features/onboarding/application/onboarding_providers.dart';
import 'package:banxin_calendar/features/schedule/application/schedule_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class OnboardingPage extends ConsumerStatefulWidget {
  const OnboardingPage({super.key});

  @override
  ConsumerState<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends ConsumerState<OnboardingPage> {
  static const int _stepCount = 7;

  final PageController _controller = PageController();
  var _step = 0;
  var _busy = false;
  String? _error;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _next() async {
    final strings = AppLocalizations.of(context);
    if (_step == 2) {
      final view = await ref
          .read(scheduleApplicationServiceProvider)
          .loadRulesView();
      if (view.rules.isEmpty) {
        setState(() => _error = strings.onboardingScheduleRequired);
        return;
      }
    }
    setState(() => _error = null);
    if (_step < _stepCount - 1) {
      await _controller.nextPage(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
      return;
    }
    setState(() => _busy = true);
    try {
      await ref.read(onboardingRepositoryProvider).markCompleted();
      if (mounted) context.go('/home');
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _open(String route) async {
    await context.push(route);
    if (mounted) setState(() => _error = null);
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    final steps = <_OnboardingStep>[
      _OnboardingStep(
        icon: Icons.calendar_month_outlined,
        title: strings.onboardingWelcomeTitle,
        body: strings.onboardingWelcomeBody,
      ),
      _OnboardingStep(
        icon: Icons.lock_outline,
        title: strings.onboardingPrivacyTitle,
        body: strings.onboardingPrivacyBody,
      ),
      _OnboardingStep(
        icon: Icons.event_repeat_outlined,
        title: strings.onboardingScheduleTitle,
        body: strings.onboardingScheduleBody,
        actionLabel: strings.configureScheduleRules,
        onAction: () => _open('/schedule/setup'),
      ),
      _OnboardingStep(
        icon: Icons.celebration_outlined,
        title: strings.onboardingHolidayTitle,
        body: strings.onboardingHolidayBody,
        actionLabel: strings.updateHolidayData,
        onAction: () => _open('/settings/holiday'),
      ),
      _OnboardingStep(
        icon: Icons.payments_outlined,
        title: strings.onboardingWageTitle,
        body: strings.onboardingWageBody,
        actionLabel: strings.setupWageRule,
        onAction: () => _open('/settings/wage'),
      ),
      _OnboardingStep(
        icon: Icons.alarm_outlined,
        title: strings.onboardingAlarmTitle,
        body: strings.onboardingAlarmBody,
        actionLabel: strings.settingsAlarm,
        onAction: () => _open('/settings/alarm'),
      ),
      _OnboardingStep(
        icon: Icons.check_circle_outline,
        title: strings.onboardingDoneTitle,
        body: strings.onboardingDoneBody,
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(strings.onboardingProgress(_step + 1, _stepCount)),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            LinearProgressIndicator(value: (_step + 1) / _stepCount),
            Expanded(
              child: PageView.builder(
                controller: _controller,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: steps.length,
                onPageChanged: (value) => setState(() => _step = value),
                itemBuilder: (context, index) => steps[index],
              ),
            ),
            if (_error != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  _error!,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: <Widget>[
                  if (_step > 0)
                    TextButton(
                      onPressed: _busy
                          ? null
                          : () => _controller.previousPage(
                              duration: const Duration(milliseconds: 250),
                              curve: Curves.easeOut,
                            ),
                      child: Text(strings.actionBack),
                    ),
                  const Spacer(),
                  FilledButton(
                    onPressed: _busy ? null : _next,
                    child: Text(
                      _step == _stepCount - 1
                          ? strings.onboardingStartUsing
                          : strings.actionContinue,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OnboardingStep extends StatelessWidget {
  const _OnboardingStep({
    required this.icon,
    required this.title,
    required this.body,
    this.actionLabel,
    this.onAction,
  });

  final IconData icon;
  final String title;
  final String body;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(32),
      child: Column(
        children: <Widget>[
          const SizedBox(height: 40),
          Icon(icon, size: 80, color: Theme.of(context).colorScheme.primary),
          const SizedBox(height: 32),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(body, textAlign: TextAlign.center),
          if (actionLabel != null) ...<Widget>[
            const SizedBox(height: 32),
            OutlinedButton(onPressed: onAction, child: Text(actionLabel!)),
          ],
        ],
      ),
    );
  }
}
