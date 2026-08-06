import 'package:banxin_calendar/app/localization/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar.large(title: Text(strings.tabSettings)),
        SliverList.list(
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.event_repeat_outlined),
              title: Text(strings.settingsScheduleAndShift),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => context.push('/schedule/rules'),
            ),
            ListTile(
              leading: const Icon(Icons.celebration_outlined),
              title: Text(strings.holidaySettingsTitle),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => context.push('/settings/holiday'),
            ),
            ListTile(
              leading: const Icon(Icons.alarm_outlined),
              title: Text(strings.settingsAlarm),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => context.push('/settings/alarm'),
            ),
            ListTile(
              leading: const Icon(Icons.payments_outlined),
              title: Text(strings.settingsWage),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => context.push('/settings/wage'),
            ),
            ListTile(
              leading: const Icon(Icons.auto_awesome_outlined),
              title: Text(strings.settingsAssistant),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => context.push('/settings/assistant'),
            ),
            ListTile(
              leading: const Icon(Icons.backup_outlined),
              title: Text(strings.settingsBackup),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => context.push('/settings/backup'),
            ),
          ],
        ),
      ],
    );
  }
}
