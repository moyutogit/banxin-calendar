import 'package:banxin_calendar/app/app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('launches the stage zero shell', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: BanxinCalendarApp()));
    await tester.pumpAndSettle();

    expect(find.text('首页'), findsOneWidget);
    expect(find.text('工程骨架已就绪'), findsOneWidget);
  });
}
