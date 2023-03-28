import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:space_x_demo/2_application/pages/launch_detail_page/widgets/sliver_parent_header.dart';

void main() {
  Widget widgetUnderTest({required Widget child}) {
    return MaterialApp(
      home: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            delegate: SliverParentHeader(
              child: child,
            ),
          )
        ],
      ),
    );
  }

  group('SliverParentHeader', () {
    group('should be displayed correctly', () {
      testWidgets('when give a text child', (widgetTester) async {
        const text = 'test_text';
        await widgetTester.pumpWidget(widgetUnderTest(child: const Text(text)));

        await widgetTester.pumpAndSettle();

        final childWidget = find.text(text);

        expect(childWidget, findsOneWidget);
      });
    });
  });
}
