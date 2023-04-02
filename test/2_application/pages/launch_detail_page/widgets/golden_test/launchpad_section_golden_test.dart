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

  final mockScenario1 = createLaunchpadEntity();
  final mockScenario2 = createLaunchpadEntity(image: ['']);
  final mockScenario3 =
      createLaunchpadEntity(image: [ConstantsTest.mockNetworkURL]);

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
                launchpad: mockScenario1,
              ),
              name: 'empty image',
              onCreate: (scenarioWidgetKey) async {
                final placeholderImage = find.descendant(
                  of: find.byKey(scenarioWidgetKey),
                  matching: find.byWidgetPredicate(
                    (widget) => widget is Image && widget.image is AssetImage,
                  ),
                );

                final fullNameWidget = find.descendant(
                  of: find.byKey(scenarioWidgetKey),
                  matching: find.text(mockScenario1.fullName),
                );

                final nameWidget = find.descendant(
                  of: find.byKey(scenarioWidgetKey),
                  matching: find.text(mockScenario1.name),
                );

                final detailsWidget = find.descendant(
                  of: find.byKey(scenarioWidgetKey),
                  matching: find.text(mockScenario1.details),
                );

                expect(fullNameWidget, findsOneWidget);
                expect(nameWidget, findsOneWidget);
                expect(detailsWidget, findsOneWidget);
                expect(placeholderImage, findsNothing);
              },
            )
            ..addScenario(
              widget: widgetUnderTest(
                launchpad: mockScenario2,
              ),
              name: 'placeholder image',
              onCreate: (scenarioWidgetKey) async {
                final placeholderWidget = find.descendant(
                  of: find.byKey(scenarioWidgetKey),
                  matching: find.byWidgetPredicate(
                    (widget) => widget is Image && widget.image is AssetImage,
                  ),
                );

                final fullNameWidget = find.descendant(
                  of: find.byKey(scenarioWidgetKey),
                  matching: find.text(mockScenario2.fullName),
                );

                final nameWidget = find.descendant(
                  of: find.byKey(scenarioWidgetKey),
                  matching: find.text(mockScenario2.name),
                );

                final detailsWidget = find.descendant(
                  of: find.byKey(scenarioWidgetKey),
                  matching: find.text(mockScenario2.details),
                );

                expect(fullNameWidget, findsOneWidget);
                expect(nameWidget, findsOneWidget);
                expect(detailsWidget, findsOneWidget);
                expect(placeholderWidget, findsOneWidget);
              },
            )
            ..addScenario(
              widget: widgetUnderTest(launchpad: mockScenario3),
              name: 'network image',
              onCreate: (scenarioWidgetKey) async {
                final networkImageWidget = find.descendant(
                  of: find.byKey(scenarioWidgetKey),
                  matching: find.byWidgetPredicate(
                    (widget) => widget is Image && widget.image is NetworkImage,
                  ),
                );

                final fullNameWidget = find.descendant(
                  of: find.byKey(scenarioWidgetKey),
                  matching: find.text(mockScenario3.fullName),
                );

                final nameWidget = find.descendant(
                  of: find.byKey(scenarioWidgetKey),
                  matching: find.text(mockScenario3.name),
                );

                final detailsWidget = find.descendant(
                  of: find.byKey(scenarioWidgetKey),
                  matching: find.text(mockScenario3.details),
                );

                final matchExactImageUrl = find.descendant(
                  of: find.byKey(scenarioWidgetKey),
                  matching: find.widgetWithImage(
                    LaunchpadSection,
                    const NetworkImage(ConstantsTest.mockNetworkURL),
                  ),
                );

                expect(matchExactImageUrl, findsOneWidget);
                expect(fullNameWidget, findsOneWidget);
                expect(nameWidget, findsOneWidget);
                expect(detailsWidget, findsOneWidget);
                expect(networkImageWidget, findsOneWidget);
              },
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
