import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:space_x_demo/1_domain/entities/crew_entity.dart';
import 'package:space_x_demo/2_application/pages/launch_detail_page/widgets/crews_section.dart';
import 'package:space_x_demo/generated/l10n.dart';

import '../../../../../../test_utils/test_utils.dart';

void main() {
  Widget widgetUnderTest({required List<CrewEntity> crews}) {
    return Scaffold(
      body: CrewsSection(
        crews: crews,
        intl: S(),
      ),
    );
  }

  setUpAll(() async => await loadAppFonts());
  group('CrewSection golden', () {
    testGoldens(
      'should be displayed correctly',
      (tester) async {
        await mockNetworkImagesFor(() async {
          final builder = DeviceBuilder()
            ..overrideDevicesForAllScenarios(
              devices: [
                Device.iphone11,
                Device.tabletPortrait,
              ],
            )
            ..addScenario(
              widget: widgetUnderTest(
                crews: ConstantsTest.mockCrews,
              ),
              name: 'have some list with placeholder in crew',
            )
            ..addScenario(
              widget: widgetUnderTest(
                crews: ConstantsTest.mockNetworkImageCrews,
              ),
              name: 'have some list in crew',
            );
          await pumpDeviceBuilderWithThemeWrapper(
              tester: tester, deviceBuilder: builder);
          await screenMatchesGolden(
            tester,
            'crews_section',
            customPump: (p0) {
              return tester.pump(const Duration(milliseconds: 500));
            },
          );
        });
      },
    );
  });
}
