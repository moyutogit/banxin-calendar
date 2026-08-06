import 'package:banxin_calendar/app/app.dart';
import 'package:banxin_calendar/core/database/app_database.dart';
import 'package:banxin_calendar/core/database/database_providers.dart';
import 'package:banxin_calendar/features/schedule/application/resolve_calendar_range.dart';
import 'package:banxin_calendar/features/schedule/application/schedule_application_service.dart';
import 'package:banxin_calendar/features/schedule/data/drift_schedule_repository.dart';
import 'package:banxin_calendar/features/schedule/domain/schedule_resolver.dart';
import 'package:banxin_calendar/features/schedule/domain/value_objects.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('renders and navigates all five primary destinations', (
    tester,
  ) async {
    final database = AppDatabase.inMemory();
    addTearDown(database.close);
    await database.ensureReady();
    await tester.pumpWidget(
      ProviderScope(
        overrides: <Override>[appDatabaseProvider.overrideWithValue(database)],
        child: const BanxinCalendarApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('首页'), findsOneWidget);
    expect(find.text('日历'), findsOneWidget);
    expect(find.text('AI 助理'), findsOneWidget);
    expect(find.text('统计'), findsOneWidget);
    expect(find.text('我的'), findsOneWidget);

    await tester.tap(find.text('日历'));
    await tester.pumpAndSettle();
    expect(find.text('尚未配置排班'), findsOneWidget);

    await tester.tap(find.text('配置排班规则'));
    await tester.pumpAndSettle();
    expect(find.text('新建排班'), findsOneWidget);
    expect(find.text('双休'), findsOneWidget);

    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();

    await tester.tap(find.text('AI 助理'));
    await tester.pumpAndSettle();
    expect(find.textContaining('AI 是可选增强模块'), findsOneWidget);
  });

  testWidgets('supports dark mode and 200 percent text scaling', (
    tester,
  ) async {
    tester.platformDispatcher.platformBrightnessTestValue = Brightness.dark;
    addTearDown(tester.platformDispatcher.clearPlatformBrightnessTestValue);

    final database = AppDatabase.inMemory();
    addTearDown(database.close);
    await database.ensureReady();
    await tester.pumpWidget(
      MediaQuery(
        data: MediaQueryData(textScaler: TextScaler.linear(2)),
        child: ProviderScope(
          overrides: <Override>[
            appDatabaseProvider.overrideWithValue(database),
          ],
          child: const BanxinCalendarApp(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('工程骨架已就绪'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('completes schedule setup and renders the generated calendar', (
    tester,
  ) async {
    final database = AppDatabase.inMemory();
    addTearDown(database.close);
    await database.ensureReady();
    await tester.pumpWidget(
      ProviderScope(
        overrides: <Override>[appDatabaseProvider.overrideWithValue(database)],
        child: const BanxinCalendarApp(),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('日历'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('配置排班规则'));
    await tester.pumpAndSettle();

    for (var step = 0; step < 3; step++) {
      final continueButton = find.widgetWithText(FilledButton, '继续').last;
      tester.widget<FilledButton>(continueButton).onPressed!();
      await tester.pumpAndSettle();
    }

    expect(find.text('未来 14 天预览'), findsWidgets);
    final saveButton = find.widgetWithText(FilledButton, '保存').last;
    tester.widget<FilledButton>(saveButton).onPressed!();
    await tester.pumpAndSettle();

    expect(find.text('尚未配置排班'), findsNothing);
    expect(await database.select(database.scheduleRules).get(), hasLength(1));
    expect(await database.select(database.shiftTemplates).get(), hasLength(5));
    expect(tester.takeException(), isNull);
  });

  testWidgets('calendar remains usable in dark mode at 200 percent text', (
    tester,
  ) async {
    tester.platformDispatcher.platformBrightnessTestValue = Brightness.dark;
    addTearDown(tester.platformDispatcher.clearPlatformBrightnessTestValue);
    final database = AppDatabase.inMemory();
    addTearDown(database.close);
    await database.ensureReady();
    await _seedSchedule(database);

    await tester.pumpWidget(
      MediaQuery(
        data: const MediaQueryData(textScaler: TextScaler.linear(2)),
        child: ProviderScope(
          overrides: <Override>[
            appDatabaseProvider.overrideWithValue(database),
          ],
          child: const BanxinCalendarApp(),
        ),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('日历'));
    await tester.pumpAndSettle();

    expect(find.text('尚未配置排班'), findsNothing);
    expect(find.byTooltip('上个月'), findsOneWidget);
    expect(find.byTooltip('下个月'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}

Future<void> _seedSchedule(AppDatabase database) async {
  final repository = DriftScheduleRepository(database);
  final service = ScheduleApplicationService(
    repository,
    ResolveCalendarRange(repository, ScheduleResolver()),
  );
  final now = DateTime.now();
  await service.saveSetup(
    ScheduleSetupDraft(
      mode: SchedulePresetMode.fiveDay,
      ruleName: '测试排班',
      shiftName: '白班',
      shiftShortName: '白',
      startMinute: 9 * 60,
      endMinute: 18 * 60,
      crossDay: false,
      unpaidBreakMinutes: 60,
      anchorDate: LocalDate(now.year, now.month, 1),
      shiftId: ShiftId('widget-shift'),
      ruleId: RuleId('widget-rule'),
    ),
  );
}
