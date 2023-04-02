import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:mocktail/mocktail.dart';
import 'package:space_x_demo/2_application/pages/launch_list_page/widgets/filter_section.dart';

import '../../../../../../test_utils/test_utils.dart';

abstract class OnCustomButtonTap {
  void call();
}

class MockOnCustomButtonTap extends Mock implements OnCustomButtonTap {}

void main() {
  Widget widgetUnderTest(
      {required String hintText, Key key = const Key('T1')}) {
    return Scaffold(
      body: FilterSection(
        hintText: hintText,
        key: key,
      ),
    );
  }

  group('FilterSection golden', () {
    final mockOnTab = MockOnCustomButtonTap();

    testGoldens('should be displayed correctly', (tester) async {
      final builder = DeviceBuilder()
        ..overrideDevicesForAllScenarios(
            devices: [Device.iphone11, Device.tabletPortrait])
        ..addScenario(
          widget: widgetUnderTest(
            hintText:
                'Search Amet excepteur eiusmod in dolor in et.Sint adipisicing nisi deserunt sint in irure nisi....',
          ),
          name: 'normal hint test',
          onCreate: (scenarioWidgetKey) async {
            final filterSection = find.descendant(
              of: find.byKey(scenarioWidgetKey),
              matching: find.byKey(const Key('T1')),
            );
            final textInput = find.descendant(
              of: filterSection,
              matching: find.textContaining(
                  'Search Amet excepteur eiusmod in dolor in et.Sint adipisicing nisi deserunt sint in irure nisi....'),
            );

            final iconButtonWidget = find.descendant(
              of: filterSection,
              matching: find.widgetWithIcon(IconButton, Icons.filter_alt),
            );

            expect(iconButtonWidget, findsOneWidget);
            expect(textInput, findsOneWidget);
          },
        )
        ..addScenario(
          widget: widgetUnderTest(
            hintText: 'Search...',
            key: const Key('T2'),
          ),
          name: 'normal hint test',
          onCreate: (scenarioWidgetKey) async {
            final filterSection = find.descendant(
              of: find.byKey(scenarioWidgetKey),
              matching: find.byKey(const Key('T2')),
            );

            final textInput = find.descendant(
              of: filterSection,
              matching: find.byType(TextFormField),
            );

            await tester.enterText(textInput, 'ABCDE');

            final findTextInTextFieldWidget = find.descendant(
              of: filterSection,
              matching: find.text('ABCDE'),
            );

            expect(textInput, findsOneWidget);
            expect(filterSection, findsOneWidget);
            expect(findTextInTextFieldWidget, findsOneWidget);
          },
        );

      await pumpDeviceBuilderWithThemeWrapper(
          tester: tester, deviceBuilder: builder);
      await screenMatchesGolden(tester, 'filter_section');
    });
  });
}
