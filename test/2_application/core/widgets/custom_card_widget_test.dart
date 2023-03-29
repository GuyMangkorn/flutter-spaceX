import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:space_x_demo/2_application/core/widgets/custom_card.dart';

void main() {
  Widget widgetUnderTest({required Widget child}) {
    return MaterialApp(
      home: CustomCard(child: child),
    );
  }

  group('CustomCard', () {
    group('should be display correctly', () {
      testWidgets('when a child widget was given', (widgetTester) async {
        const text = 'test_text';
        const childWidget = Text(text);

        await widgetTester.pumpWidget(widgetUnderTest(child: childWidget));
        await widgetTester.pumpAndSettle();

        final findChildWidgetByText = find.text(text);
        final findChildWidgetByType = find.byType(Text);

        expect(findChildWidgetByText, findsOneWidget);
        expect(findChildWidgetByType, findsOneWidget);
      });
    });
  });
}
