import 'package:banxin_calendar/app/localization/generated/app_localizations.dart';
import 'package:banxin_calendar/app/theme/app_theme.dart';
import 'package:flutter/material.dart';

class ScheduleRulesPage extends StatelessWidget {
  const ScheduleRulesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: Text(strings.scheduleRulesTitle)),
      body: SafeArea(
        child: ListView(
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
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              strings.supportedScheduleModes,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: AppSpacing.sm),
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: <Widget>[
                Chip(label: Text(strings.scheduleModeFiveDay)),
                Chip(label: Text(strings.scheduleModeSixDay)),
                Chip(label: Text(strings.scheduleModeAlternatingWeek)),
                Chip(label: Text(strings.scheduleModeCustomCycle)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
