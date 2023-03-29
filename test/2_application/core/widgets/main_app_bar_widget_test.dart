import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:space_x_demo/2_application/core/widgets/main_app_bar.dart';

void main() {
  Widget widgetUnderTest({required String title}) {
    return MaterialApp(
      home: MainAppBar(
        title: title,
      ),
    );
  }

  group('MainAppBar', () {
    group('should be display correctly', () {
      testWidgets('when a title was given', (widgetTester) async {
        const text = 'title text';

        await widgetTester.pumpWidget(widgetUnderTest(title: text));
        await widgetTester.pump();

        final findWidgetByText = find.text(text);
        final paramsWidget =
            widgetTester.widget<MainAppBar>(find.byType(MainAppBar)).title;

        expect(findWidgetByText, findsOneWidget);
        expect(paramsWidget, text);
      });
    });
  });
}
