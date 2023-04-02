import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:space_x_demo/1_domain/entities/launch_entity.dart';
import 'package:space_x_demo/2_application/pages/launch_list_page/widgets/bottom_list_section.dart';

import '../../../../../../test_utils/test_utils.dart';

void main() {
  Widget widgetUnderTest({required List<LaunchEntity> listData}) {
    return Scaffold(
      body: Column(
        children: [
          BottomListSection(
            listData: listData,
          ),
        ],
      ),
    );
  }

  group('BottomListSection golden', () {
    testGoldens(
      'should be displayed correctly',
      (tester) async {
        await mockNetworkImagesFor(() async {
          final builder = DeviceBuilder()
            ..overrideDevicesForAllScenarios(devices: [
              Device.iphone11,
              Device.tabletPortrait,
            ])
            ..addScenario(
              widget: widgetUnderTest(listData: ConstantsTest.mockListLaunch),
              name: 'list with placeholder',
            )
            ..addScenario(
              widget: widgetUnderTest(
                  listData: ConstantsTest.mockListLaunchNetworkImage),
              name: 'list with network image',
            );

          await pumpDeviceBuilderWithThemeWrapper(
              tester: tester, deviceBuilder: builder);
          await screenMatchesGolden(tester, 'bottom_list_section',
              customPump: (p0) {
            return tester.pump(const Duration(milliseconds: 500));
          });
        });
      },
    );
  });
}
