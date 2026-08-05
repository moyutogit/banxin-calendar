import 'package:banxin_calendar/core/database/app_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  throw StateError(
    'AppDatabase must be supplied by the application bootstrap.',
  );
});
