import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:space_x_demo/1_domain/entities/crew_entity.dart';
import 'package:space_x_demo/2_application/pages/launch_detail_page/widgets/crews_section.dart';
import 'package:space_x_demo/generated/l10n.dart';

import '../../../../constants_test.dart';

const mockLength = 10;
void main() {
  final mockCrews = List.generate(
    mockLength,
    (index) => CrewEntity(
      id: 'id',
      name: 'name$index',
      agency: 'agency',
      image: ConstantsTest.mockNetworkURL,
      wikipedia: 'wikipedia',
      status: 'status',
    ),
  );

  Widget widgetUnderTest({required List<CrewEntity> crews}) {
    return MaterialApp(
      home: CrewsSection(crews: crews, intl: S()),
    );
  }

  group('CrewsSection', () {
    group('should be display correctly', () {
      testWidgets('when a list of crew and image was given',
          (widgetTester) async {
        await mockNetworkImagesFor(() async =>
            await widgetTester.pumpWidget(widgetUnderTest(crews: mockCrews)));
        await widgetTester.pump(const Duration(milliseconds: 500));

        final item1 = find.text('name0');
        final item2 = find.text('name1');
        expect(item1, findsOneWidget);
        expect(item2, findsOneWidget);

        final imageWidget = find.byWidgetPredicate(
            (widget) => widget is Image && widget.image is NetworkImage);

        expect(
          imageWidget,
          findsAtLeastNWidgets(1),
        );
      });

      testWidgets('when a long name was given', (widgetTester) async {
        const name =
            'Eu id laborum minim ea esse sunt.Et qui sint quis ipsum proident consectetur et irure quis Lorem duis amet cupidatat.';
        await widgetTester.pumpWidget(widgetUnderTest(crews: const [
          CrewEntity(
            id: 'id',
            name: name,
            agency: 'agency',
            image: '',
            wikipedia: 'wikipedia',
            status: 'status',
          ),
        ]));
        await widgetTester.pump(const Duration(milliseconds: 500));

        final longNameWidget = find.textContaining(name);
        expect(longNameWidget, findsOneWidget);
      });

      testWidgets('when an image wasn\'t given', (widgetTester) async {
        const name = 'test_name';
        await widgetTester.pumpWidget(widgetUnderTest(crews: const [
          CrewEntity(
            id: 'id',
            name: name,
            agency: 'agency',
            image: '',
            wikipedia: 'wikipedia',
            status: 'status',
          ),
        ]));
        await widgetTester.pump(const Duration(milliseconds: 500));
        final imageWidget = find.byWidgetPredicate(
            (widget) => widget is Image && widget.image is AssetImage);

        expect(
          imageWidget,
          findsOneWidget
        );
      });
    });
  });
}
