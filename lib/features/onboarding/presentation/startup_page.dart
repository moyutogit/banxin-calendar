import 'dart:async';

import 'package:banxin_calendar/features/onboarding/application/onboarding_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class StartupPage extends ConsumerStatefulWidget {
  const StartupPage({super.key});

  @override
  ConsumerState<StartupPage> createState() => _StartupPageState();
}

class _StartupPageState extends ConsumerState<StartupPage> {
  @override
  void initState() {
    super.initState();
    unawaited(_route());
  }

  Future<void> _route() async {
    final completed = await ref
        .read(onboardingRepositoryProvider)
        .isCompleted();
    if (mounted) context.go(completed ? '/home' : '/onboarding');
  }

  @override
  Widget build(BuildContext context) =>
      const Scaffold(body: Center(child: CircularProgressIndicator()));
}
