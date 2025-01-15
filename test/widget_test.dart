import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_mvvm/main.dart';

void main() {
  testWidgets('TechPulse app smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: TechPulseApp(),
      ),
    );

    expect(find.text('TechPulse'), findsOneWidget);
  });
}
