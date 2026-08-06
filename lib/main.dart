import 'dart:async';

import 'package:banxin_calendar/app/app.dart';
import 'package:banxin_calendar/core/database/app_database.dart';
import 'package:banxin_calendar/core/database/database_providers.dart';
import 'package:banxin_calendar/core/diagnostics/app_error_reporter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  await runZonedGuarded<Future<void>>(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      final reporter = AppErrorReporter.instance;
      FlutterError.onError = (details) {
        reporter.report(details.exception, source: 'flutter_framework');
        if (!kReleaseMode) FlutterError.presentError(details);
      };
      PlatformDispatcher.instance.onError = (error, stack) {
        reporter.report(error, source: 'platform_dispatcher');
        return true;
      };
      final database = AppDatabase();
      await database.ensureReady();
      runApp(
        ProviderScope(
          overrides: <Override>[
            appDatabaseProvider.overrideWithValue(database),
          ],
          child: const BanxinCalendarApp(),
        ),
      );
    },
    (error, stack) {
      AppErrorReporter.instance.report(error, source: 'root_zone');
    },
  );
}
