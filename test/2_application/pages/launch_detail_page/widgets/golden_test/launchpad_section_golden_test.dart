import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:space_x_demo/1_domain/entities/laucnhpad_entity.dart';
import 'package:space_x_demo/2_application/pages/launch_detail_page/widgets/launchpad_section.dart';
import 'package:space_x_demo/generated/l10n.dart';

import '../../../../../../test_utils/test_utils.dart';

void main() {
  Widget widgetUnderTest({required LaunchpadEntity launchpad}) {
    return Scaffold(
      body: LaunchpadSection(
        launchpad: launchpad,
        intl: S(),
      ),
    );
  }

  group('LaunchpadSection golden', () {
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
              widget: widgetUnderTest(
                launchpad: createLaunchpadEntity(),
              ),
              name: 'empty image',
            )
            ..addScenario(
              widget: widgetUnderTest(
                launchpad: createLaunchpadEntity(image: ['']),
              ),
              name: 'placeholder image',
            )
            ..addScenario(
              widget: widgetUnderTest(
                launchpad: createLaunchpadEntity(
                    image: [ConstantsTest.mockNetworkURL]),
              ),
              name: 'network image',
            );
          await pumpDeviceBuilderWithThemeWrapper(
            tester: tester,
            deviceBuilder: builder,
          );
          await screenMatchesGolden(tester, 'launchpad_section',
              customPump: (p0) {
            return tester.pump(const Duration(milliseconds: 500));
          });
        });
      },
    );
  });
}
