import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:space_x_demo/1_domain/entities/launch_entity.dart';
import 'package:space_x_demo/2_application/pages/launch_list_page/widgets/bottom_list_section.dart';
import 'package:space_x_demo/generated/l10n.dart';

const mockLength = 4;
void main() {
  final mockData = List.generate(
    mockLength,
    (index) => LaunchEntity(
      dateUtc: 'dateUtc',
      id: 'id$index',
      name: 'name$index',
      success: true,
      upcoming: false,
      images: const [],
      patch: '',
    ),
  );

  Widget widgetUnderTest({
    required List<LaunchEntity> listData,
  }) {
    return MaterialApp(
      home: Column(
        children: [
          BottomListSection(
            listData: listData,
          ),
        ],
      ),
      locale: const Locale('en'),
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
    );
  }

  group('BottomListSection', () {
    group('should be displayed', () {
      testWidgets('child correctly when a list given', (widgetTester) async {
        await widgetTester.pumpWidget(widgetUnderTest(
          listData: mockData,
        ));
        await widgetTester.pumpAndSettle();

        final item1 = find.text('name0');
        final item2 = find.text('name1');

        expect(item1, findsOneWidget);
        expect(item2, findsOneWidget);
      });

      testWidgets('length correctly when a list given', (widgetTester) async {
        await widgetTester.pumpWidget(widgetUnderTest(
          listData: mockData,
        ));
        await widgetTester.pumpAndSettle();

        final listWidget = widgetTester
            .widget<BottomListSection>(find.byType(BottomListSection))
            .listData;

        expect(listWidget.length, mockLength);
      });
    });
  });
}
