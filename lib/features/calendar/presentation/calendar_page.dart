import 'package:banxin_calendar/app/localization/generated/app_localizations.dart';
import 'package:banxin_calendar/core/widgets/foundation_page.dart';
import 'package:flutter/material.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    return FoundationPage(
      title: strings.tabCalendar,
      description: strings.calendarDescription,
      icon: Icons.calendar_month_outlined,
    );
  }
}
