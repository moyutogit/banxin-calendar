import 'package:banxin_calendar/app/localization/generated/app_localizations.dart';
import 'package:banxin_calendar/core/widgets/foundation_page.dart';
import 'package:flutter/material.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    return FoundationPage(
      title: strings.tabStatistics,
      description: strings.statisticsDescription,
      icon: Icons.bar_chart_outlined,
    );
  }
}
