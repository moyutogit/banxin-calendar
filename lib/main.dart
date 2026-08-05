import 'package:banxin_calendar/app/app.dart';
import 'package:banxin_calendar/core/database/app_database.dart';
import 'package:banxin_calendar/core/database/database_providers.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = AppDatabase();
  await database.ensureReady();
  runApp(
    ProviderScope(
      overrides: <Override>[appDatabaseProvider.overrideWithValue(database)],
      child: const BanxinCalendarApp(),
    ),
  );
}
