import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:space_x_demo/2_application/pages/launch_list_page/widgets/bottom_list_tile.dart';
import 'package:space_x_demo/generated/l10n.dart';

import '../../../../constants_test.dart';

abstract class OnCustomButtonTap {
  void call();
}

class MockOnCustomButtonTap extends Mock implements OnCustomButtonTap {}

void main() {
  Widget widgetUnderTest({
    required String id,
    required String name,
    required String date,
    required Function() onTap,
    required List<String> images,
    required bool isSuccess,
  }) {
    return MaterialApp(
      home: BottomListTile(
        id: id,
        name: name,
        date: date,
        onTap: onTap,
        images: images,
        intl: S(),
        isSuccess: isSuccess,
      ),
    );
  }

  group('BottomListTile', () {
    group('should be displayed correctly', () {
      testWidgets('when a long name given', (widgetTester) async {
        const text =
            'Magna in sit anim esse esse elit laborum qui minim duis consectetur id officia aliquip.';
        await widgetTester.pumpWidget(widgetUnderTest(
          id: 'id',
          name: text,
          date: 'date',
          onTap: () {},
          images: [],
          isSuccess: false,
        ));
        await widgetTester.pumpAndSettle();

        final titleWidget = find.textContaining(text);
        expect(titleWidget, findsOneWidget);
      });

      testWidgets('when a isSuccess was false', (widgetTester) async {
        await widgetTester.pumpWidget(widgetUnderTest(
          id: 'id',
          name: 'text',
          date: 'date',
          onTap: () {},
          images: [],
          isSuccess: false,
        ));
        await widgetTester.pumpAndSettle();

        final titleWidget = find.textContaining(S().failure);
        expect(titleWidget, findsOneWidget);
      });

      testWidgets('when a isSuccess was true', (widgetTester) async {
        await widgetTester.pumpWidget(widgetUnderTest(
          id: 'id',
          name: 'text',
          date: 'date',
          onTap: () {},
          images: [],
          isSuccess: true,
        ));
        await widgetTester.pumpAndSettle();

        final titleWidget = find.textContaining(S().success);
        expect(titleWidget, findsOneWidget);
      });

      testWidgets('a placeholder when not given an image',
          (widgetTester) async {
        await widgetTester.pumpWidget(widgetUnderTest(
          id: 'id',
          name: 'text',
          date: 'date',
          onTap: () {},
          images: [],
          isSuccess: true,
        ));
        await widgetTester.pump();

        expect(
            find.byWidgetPredicate(
                (widget) => widget is Image && widget.image is AssetImage),
            findsOneWidget);
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
            isSuccess: true,
          )),
        );

        await widgetTester.pump(const Duration(milliseconds: 500));

        expect(
            find.byWidgetPredicate((widget) =>
                widget is Image &&
                widget.image is NetworkImage &&
                widget.width! > 0.0),
            findsOneWidget);
      });
    });

    group('should displayed static text', () {
      testWidgets('Status: Launch (intl.status_launched)',
          (widgetTester) async {
        await widgetTester.pumpWidget(widgetUnderTest(
          id: 'id',
          name: 'text',
          date: 'date',
          onTap: () {},
          images: [],
          isSuccess: true,
        ));
        await widgetTester.pumpAndSettle();

        final titleWidget = find.textContaining(S().launch_status);
        expect(titleWidget, findsOneWidget);
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
          isSuccess: false,
        ));
        await widgetTester.pump();

        final pressWidget = find.byType(BottomListTile);

        await widgetTester.tap(pressWidget);
        await widgetTester.pump(const Duration(milliseconds: 500));

        verify(() => mockOnTab.call()).called(1);
      });
    });
  });
}
