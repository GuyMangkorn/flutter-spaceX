import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:space_x_demo/2_application/core/widgets/fade_load_image.dart';

import '../../../../../test_utils/test_utils.dart';

void main() {
  Widget widgetUnderTest({
    required String image,
    double? width,
    double? height,
  }) {
    return Scaffold(
      body: FadeLoadImage(
        image: image,
        width: width,
        height: height,
      ),
    );
  }

  group('FadeLoadImage golden', () {
    testGoldens(
      'should be displayed correctly',
      (tester) async {
        await mockNetworkImagesFor(() async {
          final builder = DeviceBuilder()
            ..overrideDevicesForAllScenarios(devices: [
              Device.iphone11,
              const Device(
                name: '140 x 140',
                size: Size(140, 140),
              ),
              const Device(
                name: '200 x 200',
                size: Size(200, 200),
              ),
            ])
            ..addScenario(
              widget: widgetUnderTest(image: ''),
              name: 'no image show placeholder',
            )
            ..addScenario(
              widget: widgetUnderTest(
                image: ConstantsTest.mockNetworkURL,
              ),
              name: 'placeholder wasn\'t set width and height',
            );

          await pumpDeviceBuilderWithThemeWrapper(
              tester: tester, deviceBuilder: builder);
          await screenMatchesGolden(
            tester,
            'fade_load_image',
            customPump: (p0) {
              return tester.pump(const Duration(milliseconds: 500));
            },
          );
        });
      },
    );
  });
}
