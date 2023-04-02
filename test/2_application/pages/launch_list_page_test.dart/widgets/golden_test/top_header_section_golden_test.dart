import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:space_x_demo/2_application/pages/launch_list_page/widgets/top_header_section.dart';

import '../../../../../../test_utils/test_utils.dart';

void main() {
  group('TopHeaderSection golden', () {
    Widget widgetUnderTest({required String title}) {
      return Scaffold(
        body: TopHeaderSection(title: title),
      );
    }

    testGoldens('should be displayed correctly', (tester) async {
      final builder = DeviceBuilder()
        ..overrideDevicesForAllScenarios(
            devices: [Device.iphone11, Device.tabletPortrait])
        ..addScenario(
            widget: widgetUnderTest(title: 'Title'), name: 'normal text')
        ..addScenario(
          widget: widgetUnderTest(
            title:
                'Title Non eiusmod nostrud minim do magna dolor proident reprehenderit.In Lorem et excepteur minim elit sunt culpa anim',
          ),
          name: 'long text',
        );

      await pumpDeviceBuilderWithThemeWrapper(
          tester: tester, deviceBuilder: builder);
      await screenMatchesGolden(
        tester,
        'top_header_section',
        customPump: (_) {
          return tester.pump(const Duration(milliseconds: 500));
        },
      );
    });
  });
}
