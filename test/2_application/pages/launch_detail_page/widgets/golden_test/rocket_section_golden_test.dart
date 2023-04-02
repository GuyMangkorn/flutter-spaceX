import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:space_x_demo/1_domain/entities/rocket_entity.dart';
import 'package:space_x_demo/2_application/pages/launch_detail_page/widgets/rocket_section.dart';
import 'package:space_x_demo/generated/l10n.dart';

import '../../../../../../test_utils/test_utils.dart';

void main() {
  Widget widgetUnderTest({required RocketEntity rocket}) {
    return Scaffold(
      body: RocketSection(
        rocket: rocket,
        intl: S(),
      ),
    );
  }

  group('RocketSection golden', () {
    testGoldens(
      'should be displayed correctly',
      (tester) async {
        await mockNetworkImagesFor(() async {
          final builder = DeviceBuilder()
            ..overrideDevicesForAllScenarios(
                devices: [Device.iphone11, Device.tabletPortrait])
            ..addScenario(
              widget: widgetUnderTest(
                rocket: createRocketEntity(),
              ),
              name: 'empty image',
            )
            ..addScenario(
              widget: widgetUnderTest(
                rocket: createRocketEntity(images: ['', '', '']),
              ),
              name: 'list placeholder image',
            )
            ..addScenario(
              widget: widgetUnderTest(
                rocket: createRocketEntity(images: [
                  ConstantsTest.mockNetworkURL,
                  ConstantsTest.mockNetworkURL,
                  ConstantsTest.mockNetworkURL
                ]),
              ),
              name: 'list network image',
            );

          await pumpDeviceBuilderWithThemeWrapper(
              tester: tester, deviceBuilder: builder);
          await screenMatchesGolden(tester, 'rocket_section', customPump: (p0) {
            return tester.pump(const Duration(milliseconds: 500));
          });
        });
      },
    );
  });
}
