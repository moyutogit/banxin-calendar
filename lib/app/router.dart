import 'package:banxin_calendar/app/shell/app_shell.dart';
import 'package:banxin_calendar/features/alarm/presentation/alarm_settings_page.dart';
import 'package:banxin_calendar/features/assistant/presentation/assistant_page.dart';
import 'package:banxin_calendar/features/assistant/presentation/assistant_settings_page.dart';
import 'package:banxin_calendar/features/backup/presentation/backup_settings_page.dart';
import 'package:banxin_calendar/features/calendar/presentation/calendar_page.dart';
import 'package:banxin_calendar/features/calendar/presentation/day_details_page.dart';
import 'package:banxin_calendar/features/holiday/presentation/holiday_settings_page.dart';
import 'package:banxin_calendar/features/home/presentation/home_page.dart';
import 'package:banxin_calendar/features/onboarding/presentation/onboarding_page.dart';
import 'package:banxin_calendar/features/onboarding/presentation/startup_page.dart';
import 'package:banxin_calendar/features/schedule/application/schedule_application_service.dart';
import 'package:banxin_calendar/features/schedule/domain/value_objects.dart';
import 'package:banxin_calendar/features/schedule/presentation/schedule_rules_page.dart';
import 'package:banxin_calendar/features/schedule/presentation/schedule_setup_page.dart';
import 'package:banxin_calendar/features/schedule/presentation/shift_templates_page.dart';
import 'package:banxin_calendar/features/settings/presentation/settings_page.dart';
import 'package:banxin_calendar/features/statistics/presentation/statistics_page.dart';
import 'package:banxin_calendar/features/wage/presentation/wage_settings_page.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final router = GoRouter(
    initialLocation: '/startup',
    routes: <RouteBase>[
      GoRoute(path: '/startup', builder: (_, _) => const StartupPage()),
      GoRoute(path: '/onboarding', builder: (_, _) => const OnboardingPage()),
      StatefulShellRoute.indexedStack(
        builder:
            (
              BuildContext context,
              GoRouterState state,
              StatefulNavigationShell navigationShell,
            ) => AppShell(navigationShell: navigationShell),
        branches: <StatefulShellBranch>[
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(path: '/home', builder: (_, _) => const HomePage()),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: '/calendar',
                builder: (_, _) => const CalendarPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: '/assistant',
                builder: (_, _) => const AssistantPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: '/statistics',
                builder: (_, _) => const StatisticsPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: '/settings',
                builder: (_, _) => const SettingsPage(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/schedule/rules',
        builder: (_, _) => const ScheduleRulesPage(),
      ),
      GoRoute(
        path: '/schedule/setup',
        builder: (_, state) =>
            ScheduleSetupPage(initialDraft: state.extra as ScheduleSetupDraft?),
      ),
      GoRoute(
        path: '/schedule/shifts',
        builder: (_, _) => const ShiftTemplatesPage(),
      ),
      GoRoute(
        path: '/day/:date',
        builder: (_, state) => DayDetailsPage(
          date: LocalDate.parse(state.pathParameters['date']!),
        ),
      ),
      GoRoute(
        path: '/settings/holiday',
        builder: (_, _) => const HolidaySettingsPage(),
      ),
      GoRoute(
        path: '/settings/alarm',
        builder: (_, _) => const AlarmSettingsPage(),
      ),
      GoRoute(
        path: '/settings/wage',
        builder: (_, _) => const WageSettingsPage(),
      ),
      GoRoute(
        path: '/settings/assistant',
        builder: (_, _) => const AssistantSettingsPage(),
      ),
      GoRoute(
        path: '/settings/backup',
        builder: (_, _) => const BackupSettingsPage(),
      ),
    ],
  );
  ref.onDispose(router.dispose);
  return router;
});
