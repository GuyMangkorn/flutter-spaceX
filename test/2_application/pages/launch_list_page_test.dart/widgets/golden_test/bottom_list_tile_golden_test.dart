import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:space_x_demo/2_application/pages/launch_list_page/widgets/bottom_list_tile.dart';
import 'package:space_x_demo/generated/l10n.dart';

import '../../../../../../test_utils/test_utils.dart';

void main() {
  Widget widgetUnderTest({
    required String id,
    required String name,
    required String date,
    required Function() onTap,
    required List<String> images,
    required bool isSuccess,
  }) {
    return Scaffold(
      body: BottomListTile(
          id: id,
          name: name,
          date: date,
          onTap: onTap,
          images: images,
          intl: S(),
          isSuccess: isSuccess),
    );
  }

  group('BottomListTile golden', () {
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
                id: 'id',
                name: 'test_name',
                date: '12-12-2022',
                onTap: () {},
                images: [''],
                isSuccess: true,
              ),
              name: 'normal text with placeholder',
            )
            ..addScenario(
              widget: widgetUnderTest(
                id: 'id',
                name:
                    'test_name Quis sit deserunt aliquip consectetur ad aliquip commodo.Ad consequat deserunt ipsum laboris.',
                date:
                    '12-12-2022 Mollit tempor culpa magna nostrud voluptate et occaecat.',
                onTap: () {},
                images: [''],
                isSuccess: true,
              ),
              name: 'longe text with placeholder',
            )
            ..addScenario(
              widget: widgetUnderTest(
                id: 'id',
                name: 'test_name',
                date: '12-12-2022',
                onTap: () {},
                images: [ConstantsTest.mockNetworkURL],
                isSuccess: true,
              ),
              name: 'normal text with network image',
            );
          await pumpDeviceBuilderWithThemeWrapper(
            tester: tester,
            deviceBuilder: builder,
          );
          await screenMatchesGolden(
            tester,
            'bottom_list_tile',
            customPump: (p0) {
              return tester.pump(const Duration(milliseconds: 500));
            },
          );
        });
      },
    );
  });
}
