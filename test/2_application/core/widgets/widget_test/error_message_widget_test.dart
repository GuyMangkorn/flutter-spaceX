import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:space_x_demo/2_application/core/widgets/error_message.dart';

void main() {
  Widget widgetUnderTest({required String message}) {
    return MaterialApp(
      home: ErrorMessage(
        message: message,
      ),
    );
  }

  group('ErrorMessage', () {
    group('should be display correctly', () {
      testWidgets('when a text was given', (widgetTester) async {
        const text = 'test_text';

        await widgetTester.pumpWidget(widgetUnderTest(message: text));
        await widgetTester.pumpAndSettle();

        final findWidgetByText = find.text(text);
        final paramsWidget = widgetTester
            .widget<ErrorMessage>(find.byType(ErrorMessage))
            .message;

        expect(findWidgetByText, findsOneWidget);
        expect(paramsWidget, text);
      });
    });
  });
}
