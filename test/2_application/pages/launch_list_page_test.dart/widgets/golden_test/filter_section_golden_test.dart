import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:space_x_demo/2_application/pages/launch_list_page/widgets/filter_section.dart';

import '../../../../../../test_utils/test_utils.dart';

void main() {
  Widget widgetUnderTest({required String hintText, required Key key}) {
    return Scaffold(
      body: FilterSection(
        hintText: hintText,
        key: key,
      ),
    );
  }

  group('FilterSection golden', () {
    testGoldens('should be displayed correctly', (tester) async {
      final builder = DeviceBuilder()
        ..overrideDevicesForAllScenarios(
            devices: [Device.iphone11, Device.tabletPortrait])
        ..addScenario(
          widget: widgetUnderTest(
            hintText: 'Search...',
            key: const Key('t1'),
          ),
          name: 'normal hint test',
        )
        ..addScenario(
          widget: widgetUnderTest(
            hintText:
                'Search Amet excepteur eiusmod in dolor in et.Sint adipisicing nisi deserunt sint in irure nisi....',
            key: const Key('t2'),
          ),
          name: 'normal hint test',
        )
        ..addScenario(
          widget: widgetUnderTest(
            hintText: 'Search...',
            key: const Key('t3'),
          ),
          name: 'normal hint test',
          onCreate: (scenarioWidgetKey) async {
            final filterSection = find.descendant(
              of: find.byKey(scenarioWidgetKey),
              matching: find.byKey(const Key('t3')),
            );
            expect(filterSection, findsOneWidget);

            final textInput = find.descendant(
              of: filterSection,
              matching: find.byType(TextFormField),
            );
            expect(textInput, findsOneWidget);

            await tester.enterText(textInput, 'ABCDE');

            final findTextInTextFieldWidget = find.descendant(
              of: filterSection,
              matching: find.text('ABCDE'),
            );

            expect(findTextInTextFieldWidget, findsOneWidget);
          },
        );

      await pumpDeviceBuilderWithThemeWrapper(
          tester: tester, deviceBuilder: builder);
      await screenMatchesGolden(tester, 'filter_section');
    });
  });
}
