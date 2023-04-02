import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:space_x_demo/2_application/pages/launch_list_page/widgets/filter_section.dart';
import 'package:space_x_demo/generated/l10n.dart';

void main() {
  Widget widgetUnderTest({required String hintText}) {
    return MaterialApp(
      home: Material(child: FilterSection(hintText: hintText)),
    );
  }

  group('FilterSection', () {
    testWidgets('should be displayed correctly when a hint text added',
        (widgetTester) async {
      final text = S().hint_text;

      await widgetTester.pumpWidget(widgetUnderTest(hintText: text));
      await widgetTester.pumpAndSettle();

      final textFieldWidget = find.text(text);
      expect(textFieldWidget, findsOneWidget);
    });

    testWidgets('should be displayed correctly when ABCDE typed by user',
        (widgetTester) async {
      final text = S().hint_text;

      await widgetTester.pumpWidget(widgetUnderTest(hintText: text));
      await widgetTester.pumpAndSettle();

      final textFieldWidget = find.byType(TextFormField);

      await widgetTester.enterText(textFieldWidget, 'ABCDE');
      await widgetTester.pumpAndSettle();

      final findTextInTextFieldWidget = find.text('ABCDE');

      expect(findTextInTextFieldWidget, findsOneWidget);
    });
  });
}
