import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:space_x_demo/0_data/models/launch_model.dart';
import 'package:space_x_demo/2_application/pages/launch_list_page/widgets/top_list_section.dart';

const mockLength = 4;

void main() {
  final mockData = List.generate(
    mockLength,
    (index) => LaunchModel(
      dateUtc: 'dateUtc',
      id: 'id$index',
      name: 'name$index',
      success: true,
      upcoming: false,
      images: const [],
      patch: '',
    ),
  );
  Widget widgetUnderTest({required List<LaunchModel> listData}) {
    return MaterialApp(
      home: TopListSection(listData: listData),
    );
  }

  group('should be displayed correctly', () {
    group('should be displayed', () {
      testWidgets('child correctly when a list given', (widgetTester) async {
        await widgetTester.pumpWidget(widgetUnderTest(
          listData: mockData,
        ));
        await widgetTester.pumpAndSettle();

        final item1 = find.text('name0');
        final item2 = find.text('name3');

        expect(item1, findsOneWidget);
        expect(item2, findsNothing);
      });
    });

    testWidgets('length correctly when a list given', (widgetTester) async {
      await widgetTester.pumpWidget(widgetUnderTest(
        listData: mockData,
      ));
      await widgetTester.pumpAndSettle();

      final listWidget = widgetTester
          .widget<TopListSection>(find.byType(TopListSection))
          .listData;

      expect(listWidget.length, mockLength);
    });
  });
}
