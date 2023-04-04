import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:space_x_demo/0_data/models/crew_model.dart';
import 'package:space_x_demo/2_application/pages/launch_detail_page/widgets/crews_section.dart';
import 'package:space_x_demo/constants/mock_constants.dart';
import 'package:space_x_demo/generated/l10n.dart';

import '../../../../../../test_utils/test_utils.dart';

void main() {
  Widget widgetUnderTest({required List<CrewModel> crews}) {
    return Scaffold(
      body: CrewsSection(
        crews: crews,
        intl: S(),
      ),
    );
  }

  final mockCrewScenario1 = MockConstants.mockCrews;
  final mockCrewScenario2 = MockConstants.mockNetworkImageCrews;

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
                crews: mockCrewScenario1,
              ),
              name: 'have some list with placeholder in crew',
              onCreate: (scenarioWidgetKey) async {
                final placeholderWidget = find.descendant(
                  of: find.byKey(scenarioWidgetKey),
                  matching: find.byWidgetPredicate((widget) =>
                      widget is Image && widget.image is AssetImage),
                );
                final titleWidgetIndex0 = find.descendant(
                  of: find.byKey(scenarioWidgetKey),
                  matching: find.text(mockCrewScenario1[0].name),
                );

                expect(titleWidgetIndex0, findsOneWidget);
                expect(placeholderWidget, findsAtLeastNWidgets(1));
              },
            )
            ..addScenario(
              widget: widgetUnderTest(
                crews: mockCrewScenario2,
              ),
              name: 'have some list in crew',
              onCreate: (scenarioWidgetKey) async {
                final placeholderWidget = find.descendant(
                  of: find.byKey(scenarioWidgetKey),
                  matching: find.byWidgetPredicate((widget) =>
                      widget is Image && widget.image is NetworkImage),
                );
                final titleWidgetIndex0 = find.descendant(
                  of: find.byKey(scenarioWidgetKey),
                  matching: find.text(mockCrewScenario2[0].name),
                );
                final exactImageUrl = find.descendant(
                  of: find.byKey(scenarioWidgetKey),
                  matching: find.widgetWithImage(
                    CrewsSection,
                    NetworkImage(mockCrewScenario2[0].image),
                  ),
                );

                expect(exactImageUrl, findsOneWidget);
                expect(titleWidgetIndex0, findsOneWidget);
                expect(placeholderWidget, findsAtLeastNWidgets(1));
              },
            );
          await pumpDeviceBuilderWithThemeWrapper(
            tester: tester,
            deviceBuilder: builder,
          );
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
