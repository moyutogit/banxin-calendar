import 'package:banxin_calendar/core/database/app_database.dart';
import 'package:banxin_calendar/core/time/app_clock.dart';
import 'package:banxin_calendar/features/onboarding/domain/onboarding_repository.dart';

final class DriftOnboardingRepository implements OnboardingRepository {
  const DriftOnboardingRepository(
    this._database, {
    this.clock = const SystemAppClock(),
  });

  static const String metadataKey = 'onboarding_completed';

  final AppDatabase _database;
  final AppClock clock;

  @override
  Future<bool> isCompleted() async {
    final row = await (_database.select(
      _database.databaseMetadata,
    )..where((table) => table.key.equals(metadataKey))).getSingleOrNull();
    return row?.value == 'true';
  }

  @override
  Future<void> markCompleted() async {
    final now = clock.nowUtc().millisecondsSinceEpoch;
    await _database.customStatement(
      '''
      INSERT INTO database_metadata (key, value, created_at, updated_at)
      VALUES (?, 'true', ?, ?)
      ON CONFLICT(key) DO UPDATE SET value = 'true', updated_at = excluded.updated_at
      ''',
      <Object>[metadataKey, now, now],
    );
  }
}
