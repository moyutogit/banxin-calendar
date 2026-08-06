import 'package:banxin_calendar/core/database/database_providers.dart';
import 'package:banxin_calendar/features/onboarding/data/drift_onboarding_repository.dart';
import 'package:banxin_calendar/features/onboarding/domain/onboarding_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final onboardingRepositoryProvider = Provider<OnboardingRepository>(
  (ref) => DriftOnboardingRepository(ref.watch(appDatabaseProvider)),
);
