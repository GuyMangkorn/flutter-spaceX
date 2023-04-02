import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:space_x_demo/2_application/pages/launch_list_page/widgets/top_header_section.dart';

void main() {
  Widget widgetUnderTest({required String title}) {
    return MaterialApp(
      home: TopHeaderSection(title: title),
    );
  }

  group('TopHeaderSection', () {
    group('should be displayed correctly', () {
      testWidgets('when a short text given', (widgetTester) async {
        const text = 'a';

        await widgetTester.pumpWidget(widgetUnderTest(title: text));
        await widgetTester.pumpAndSettle();

        final topListHeader = find.textContaining('a');

        expect(topListHeader, findsOneWidget);
      });

      testWidgets('when a long text given', (widgetTester) async {
        const text =
            'Sint laborum labore quis exercitation nostrud incididunt minim eu proident et magna.';

        await widgetTester.pumpWidget(widgetUnderTest(title: text));
        await widgetTester.pumpAndSettle();

        final topListHeader = find.byType(TopHeaderSection);

        expect(topListHeader, findsOneWidget);
      });

      testWidgets('when no text given', (widgetTester) async {
        const text = '';

        await widgetTester.pumpWidget(widgetUnderTest(title: text));
        await widgetTester.pumpAndSettle();

        final topHeaderWidget = find.byType(TopHeaderSection);
        final headerText =
            widgetTester.widget<TopHeaderSection>(topHeaderWidget).title;
        expect(topHeaderWidget, findsOneWidget);
        expect(headerText.isEmpty, true);
      });
    });
  });
}
