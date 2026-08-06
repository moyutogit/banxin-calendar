import 'package:banxin_calendar/app/shell/app_shell.dart';
import 'package:banxin_calendar/features/assistant/presentation/assistant_page.dart';
import 'package:banxin_calendar/features/calendar/presentation/calendar_page.dart';
import 'package:banxin_calendar/features/home/presentation/home_page.dart';
import 'package:banxin_calendar/features/schedule/presentation/schedule_rules_page.dart';
import 'package:banxin_calendar/features/settings/presentation/settings_page.dart';
import 'package:banxin_calendar/features/statistics/presentation/statistics_page.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final router = GoRouter(
    initialLocation: '/home',
    routes: <RouteBase>[
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
    ],
  );
  ref.onDispose(router.dispose);
  return router;
});
