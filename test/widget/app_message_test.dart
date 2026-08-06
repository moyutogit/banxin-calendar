import 'package:banxin_calendar/core/presentation/app_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('application messages appear at the top overlay', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
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

    await tester.tap(find.byTooltip('Close'));
    await tester.pump();
    expect(message, findsNothing);
  });
}
