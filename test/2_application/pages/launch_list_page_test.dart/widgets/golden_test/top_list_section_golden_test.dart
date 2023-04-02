import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:space_x_demo/1_domain/entities/launch_entity.dart';
import 'package:space_x_demo/2_application/pages/launch_list_page/widgets/top_list_section.dart';

import '../../../../../../test_utils/test_utils.dart';

void main() {
  Widget widgetUnderTest({required List<LaunchEntity> listData}) {
    return Scaffold(
      body: TopListSection(listData: listData),
    );
  }

  group('TopListSection golden', () {
    testGoldens('should be displayed correctly', (tester) async {
      await mockNetworkImagesFor(() async {
        final builder = DeviceBuilder()
          ..overrideDevicesForAllScenarios(
              devices: [Device.iphone11, Device.tabletPortrait])
          ..addScenario(
            widget: widgetUnderTest(
              listData: ConstantsTest.mockListLaunch,
            ),
            name: 'with placeholder',
            onCreate: (scenarioWidgetKey) async {
              final placeholderImage = find.descendant(
                of: find.byKey(scenarioWidgetKey),
                matching: find.byWidgetPredicate(
                  (widget) => widget is Image && widget.image is AssetImage,
                ),
              );

              expect(placeholderImage, findsAtLeastNWidgets(1));
            },
          )
          ..addScenario(
            widget: widgetUnderTest(
              listData: ConstantsTest.mockListLaunchNetworkImage,
            ),
            name: 'with network image',
            onCreate: (scenarioWidgetKey) async {
              final placeholderImage = find.descendant(
                of: find.byKey(scenarioWidgetKey),
                matching: find.byWidgetPredicate(
                  (widget) => widget is Image && widget.image is NetworkImage,
                ),
              );

              expect(placeholderImage, findsAtLeastNWidgets(1));
            },
          );

        await pumpDeviceBuilderWithThemeWrapper(
            tester: tester, deviceBuilder: builder);
        await screenMatchesGolden(
          tester,
          'top_list_section',
          customPump: (p0) {
            return tester.pump(const Duration(milliseconds: 500));
          },
        );
      });
    });
  });
}
