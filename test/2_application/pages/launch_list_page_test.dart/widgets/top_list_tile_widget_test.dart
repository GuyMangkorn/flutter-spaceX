import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:space_x_demo/2_application/pages/launch_list_page/widgets/top_list_tile.dart';

import '../../../../../test_constant/test_constants.dart';

abstract class OnCustomButtonTap {
  void call();
}

class MockOnCustomButtonTap extends Mock implements OnCustomButtonTap {}

void main() {
  Widget widgetUnderTest({
    required String name,
    required String id,
    required String date,
    required Function() onTap,
    required List<String> images,
  }) {
    return MaterialApp(
      home: TopListItem(
        name: name,
        id: id,
        date: date,
        onTap: onTap,
        images: images,
      ),
    );
  }

  group('TopListTile', () {
    group('should be displayed correctly', () {
      testWidgets('when no text given', (widgetTester) async {
        await widgetTester.pumpWidget(widgetUnderTest(
          id: 'id',
          date: 'date',
          images: [],
          name: '',
          onTap: () {},
        ));
        await widgetTester.pump();

        final findName =
            widgetTester.widget<TopListItem>(find.byType(TopListItem)).name;
        expect(findName.isEmpty, true);
      });

      testWidgets('when a long name given', (widgetTester) async {
        const text =
            'name Dolore eiusmod proident do tempor.Est non ex voluptate ut mollit consequat aliqua excepteur irure voluptate.';
        await widgetTester.pumpWidget(widgetUnderTest(
          id: 'id',
          date: 'date',
          images: [],
          name: text,
          onTap: () {},
        ));
        await widgetTester.pump();

        final findNameWidget = find.textContaining(text);
        expect(findNameWidget, findsOneWidget);
      });

      testWidgets('a placeholder when not given an image',
          (widgetTester) async {
        await widgetTester.pumpWidget(widgetUnderTest(
          id: 'id',
          date: 'date',
          images: [],
          name: 'name',
          onTap: () {},
        ));
        await widgetTester.pump();

        final placeholderImage = find.byWidgetPredicate(
            (widget) => widget is Image && widget.image is AssetImage);

        expect(placeholderImage, findsOneWidget);
      });

      testWidgets('a first index image when given a list of image',
          (widgetTester) async {
        await mockNetworkImagesFor(
          () async => await widgetTester.pumpWidget(widgetUnderTest(
            id: 'id',
            date: 'date',
            images: [ConstantsTest.mockNetworkURL],
            name: 'name',
            onTap: () {},
          )),
        );

        await widgetTester.pump(const Duration(milliseconds: 500));

        final networkImage = find.byWidgetPredicate((widget) =>
            widget is Image &&
            widget.image is NetworkImage &&
            widget.width! > 0.0);

        expect(networkImage, findsOneWidget);
      });
    });

    group('should handle onTab', () {
      testWidgets('when user tab pressed on widget', (widgetTester) async {
        final mockOnTab = MockOnCustomButtonTap();
        await widgetTester.pumpWidget(widgetUnderTest(
          id: 'id',
          date: 'date',
          images: [],
          name: '',
          onTap: mockOnTab.call,
        ));
        await widgetTester.pump();

        final pressWidget = find.byType(TopListItem);

        await widgetTester.tap(pressWidget);
        await widgetTester.pump(const Duration(milliseconds: 500));

        verify(() => mockOnTab.call()).called(1);
      });
    });
  });
}
