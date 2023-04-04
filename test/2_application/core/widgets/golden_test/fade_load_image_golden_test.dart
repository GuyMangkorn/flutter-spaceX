import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:space_x_demo/2_application/core/widgets/fade_load_image.dart';
import 'package:space_x_demo/constants/mock_constants.dart';

import '../../../../../test_utils/test_utils.dart';

void main() {
  const double width = 400;
  const double height = 200;
  Widget widgetUnderTest({
    required String image,
    double? width,
    double? height,
  }) {
    return Scaffold(
      body: SizedBox(
        child: FadeLoadImage(
          image: image,
          width: width,
          height: height,
        ),
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
              onCreate: (scenarioWidgetKey) async {
                final placeholderWidget = find.descendant(
                  of: find.byKey(scenarioWidgetKey),
                  matching: find.byWidgetPredicate(
                    (widget) => widget is Image && widget.image is AssetImage,
                  ),
                );

                expect(placeholderWidget, findsOneWidget);
              },
            )
            ..addScenario(
              widget: widgetUnderTest(image: MockConstants.mockNetworkURL),
              name: 'placeholder wasn\'t set width and height',
              onCreate: (scenarioWidgetKey) async {
                final networkImage = find.descendant(
                  of: find.byKey(scenarioWidgetKey),
                  matching: find.byWidgetPredicate(
                    (widget) => widget is Image && widget.image is NetworkImage,
                  ),
                );

                final exactImageUrl = find.descendant(
                  of: find.byKey(scenarioWidgetKey),
                  matching: find.widgetWithImage(
                    FadeLoadImage,
                    const NetworkImage(MockConstants.mockNetworkURL),
                  ),
                );

                expect(exactImageUrl, findsOneWidget);
                expect(networkImage, findsOneWidget);
              },
            )
            ..addScenario(
              widget: widgetUnderTest(image: '', width: width, height: height),
              name: 'placeholder with fixed size image',
              onCreate: (scenarioWidgetKey) async {
                final networkImage = find.descendant(
                  of: find.byKey(scenarioWidgetKey),
                  matching: find.byWidgetPredicate(
                    (widget) =>
                        widget is Image &&
                        widget.image is AssetImage &&
                        widget.width == width &&
                        widget.height == height,
                  ),
                );

                expect(networkImage, findsOneWidget);
              },
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
