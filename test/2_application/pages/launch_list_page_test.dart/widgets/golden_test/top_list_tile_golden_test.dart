import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:space_x_demo/2_application/pages/launch_list_page/widgets/top_list_tile.dart';

import '../../../../../../test_utils/test_utils.dart';

void main() {
  Widget widgetUnderTest({
    required String name,
    required String id,
    required String date,
    required Function() onTap,
    required List<String> images,
  }) {
    return Scaffold(
      body: TopListItem(
        name: name,
        id: id,
        date: date,
        onTap: onTap,
        images: images,
      ),
    );
  }

  group('TopListTile golden', () {
    testGoldens('should be displayed correctly', (tester) async {
      await mockNetworkImagesFor(() async {
        final builder = DeviceBuilder()
          ..overrideDevicesForAllScenarios(devices: [
            Device.iphone11,
            Device.tabletPortrait,
          ])
          ..addScenario(
            widget: widgetUnderTest(
              name: 'name_test',
              id: 'id',
              date: 'date_test',
              onTap: () {},
              images: [''],
            ),
            name: 'normal text',
          )
          ..addScenario(
            widget: widgetUnderTest(
              name:
                  'name_test Labore enim ea ipsum enim nisi incididunt duis est exercitation ea mollit quis incididunt tempor.',
              id: 'id',
              date:
                  'date_test Non dolore reprehenderit qui excepteur ut culpa voluptate.',
              onTap: () {},
              images: [''],
            ),
            name: 'long text',
          )
          ..addScenario(
            widget: widgetUnderTest(
              name: 'name_test',
              id: 'id',
              date: 'date_test',
              onTap: () {},
              images: [ConstantsTest.mockNetworkURL],
            ),
            name: 'network image',
          );

        await pumpDeviceBuilderWithThemeWrapper(
            tester: tester, deviceBuilder: builder);
        await screenMatchesGolden(
          tester,
          'top_list_tile',
          customPump: (p0) {
            return tester.pump(const Duration(milliseconds: 500));
          },
        );
      });
    });
  });
}
