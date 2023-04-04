import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:space_x_demo/0_data/models/launch_model.dart';
import 'package:space_x_demo/2_application/pages/launch_list_page/widgets/bottom_list_section.dart';
import 'package:space_x_demo/constants/mock_constants.dart';

import '../../../../../../test_utils/test_utils.dart';

void main() {
  Widget widgetUnderTest({required List<LaunchModel> listData}) {
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
              widget: widgetUnderTest(listData: MockConstants.mockListLaunch),
              name: 'list with placeholder',
              onCreate: (scenarioWidgetKey) async {
                final placeholderImage = find.descendant(
                  of: find.byKey(scenarioWidgetKey),
                  matching: find.byWidgetPredicate((widget) =>
                      widget is Image && widget.image is AssetImage),
                );

                expect(placeholderImage, findsAtLeastNWidgets(3));
              },
            )
            ..addScenario(
              widget: widgetUnderTest(
                  listData: MockConstants.mockListLaunchNetworkImage),
              name: 'list with network image',
              onCreate: (scenarioWidgetKey) async {
                final networkImage = find.descendant(
                  of: find.byKey(scenarioWidgetKey),
                  matching: find.byWidgetPredicate((widget) =>
                      widget is Image && widget.image is NetworkImage),
                );
                expect(networkImage, findsAtLeastNWidgets(3));
              },
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
