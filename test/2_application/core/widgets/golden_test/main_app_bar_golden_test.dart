import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:space_x_demo/2_application/core/widgets/main_app_bar.dart';

import '../../../../../test_utils/test_utils.dart';

void main() {
  Widget widgetUnderTest({required String title}) {
    return Scaffold(
      appBar: MainAppBar(title: title),
      body: const Placeholder(),
    );
  }

  group('MainAppBar golden', () {
    testGoldens(
      'should displayed correctly',
      (tester) async {
        final builder = DeviceBuilder()
          ..overrideDevicesForAllScenarios(devices: [
            Device.iphone11,
            Device.phone,
            Device.tabletPortrait,
          ])
          ..addScenario(
            widget: widgetUnderTest(title: 'Title test'),
            name: 'normal title',
          )
          ..addScenario(
            widget: widgetUnderTest(
              title:
                  '2Lorem non velit proident adipisicing pariatur quis minim.',
            ),
            name: 'long title',
          )
          ..addScenario(
            widget: widgetUnderTest(title: ''),
            name: 'no text',
          );
        await pumpDeviceBuilderWithThemeWrapper(
          tester: tester,
          deviceBuilder: builder,
        );
        await screenMatchesGolden(
          tester,
          'main_app_bar',
          customPump: (p0) {
            return tester.pump(const Duration(milliseconds: 500));
          },
        );
      },
    );
  });
}
