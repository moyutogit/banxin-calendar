import 'package:banxin_calendar/app/localization/generated/app_localizations.dart';
import 'package:banxin_calendar/core/widgets/foundation_page.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    return FoundationPage(
      title: strings.tabSettings,
      description: strings.settingsDescription,
      icon: Icons.settings_outlined,
    );
  }
}
