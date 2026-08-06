import 'package:banxin_calendar/app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('renders and navigates all five primary destinations', (
    tester,
  ) async {
    await tester.pumpWidget(const ProviderScope(child: BanxinCalendarApp()));
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
    expect(find.text('排班规则'), findsOneWidget);
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

    await tester.pumpWidget(
      const MediaQuery(
        data: MediaQueryData(textScaler: TextScaler.linear(2)),
        child: ProviderScope(child: BanxinCalendarApp()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('工程骨架已就绪'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
