import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:space_x_demo/2_application/pages/launch_list_page/widgets/skeleton_top_list.dart';

import '../../../../../../test_utils/test_utils.dart';

void main() {
  Widget widgetUnderTest() {
    return const Scaffold(
      body: SkeletonTopList(),
    );
  }

  group('SkeletonTopList golden', () {
    testGoldens('should be displayed correctly', (tester) async {
      final builder = DeviceBuilder()
        ..overrideDevicesForAllScenarios(
            devices: [Device.iphone11, Device.tabletPortrait])
        ..addScenario(
          widget: widgetUnderTest(),
          name: 'Normal',
        );

      await pumpDeviceBuilderWithThemeWrapper(
          tester: tester, deviceBuilder: builder);
      await screenMatchesGolden(
        tester,
        'skeleton_top_list',
        customPump: (p0) {
          return tester.pump(const Duration(milliseconds: 500));
        },
      );
    });
  });
}
