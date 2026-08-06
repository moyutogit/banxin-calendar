import 'package:banxin_calendar/core/presentation/app_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('application messages appear at the top overlay', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        builder: (context, child) => AppMessageHost(child: child!),
        home: Builder(
          builder: (context) => Scaffold(
            body: Center(
              child: FilledButton(
                onPressed: () => AppMessage.show(
                  context,
                  '顶部提示',
                  type: AppMessageType.success,
                ),
                child: const Text('显示提示'),
              ),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('显示提示'));
    await tester.pump(const Duration(milliseconds: 200));

    final message = find.text('顶部提示');
    expect(message, findsOneWidget);
    expect(tester.getTopLeft(message).dy, lessThan(100));
    expect(find.byType(SnackBar), findsNothing);

    await tester.tap(_closeButtonFor(message));
    await tester.pump();
    expect(message, findsNothing);
  });

  testWidgets('manual close clears queued messages immediately', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        builder: (context, child) => AppMessageHost(child: child!),
        home: Builder(
          builder: (context) => Scaffold(
            body: FilledButton(
              onPressed: () {
                AppMessage.show(context, 'First');
                AppMessage.show(context, 'Second');
              },
              child: const Text('Show two'),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Show two'));
    await tester.pump(const Duration(milliseconds: 200));
    expect(find.text('First'), findsOneWidget);

    final closeButton = _closeButtonFor(find.text('First'));
    expect(tester.widget<IconButton>(closeButton).onPressed, isNotNull);
    await tester.tap(closeButton);
    await tester.pump();
    expect(find.text('First'), findsNothing);
    expect(find.text('Second'), findsNothing);
    await tester.pump(const Duration(seconds: 4));
    expect(find.text('Second'), findsNothing);
  });
}

Finder _closeButtonFor(Finder message) {
  final row = find.ancestor(of: message, matching: find.byType(Row));
  return find.descendant(
    of: row,
    matching: find.widgetWithIcon(IconButton, Icons.close),
  );
}
