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

  final mockScenario1 = createRocketEntity();
  final mockScenario2 = createRocketEntity(images: ['', '', '']);
  final mockScenario3 = createRocketEntity(images: [
    ConstantsTest.mockNetworkURL,
    ConstantsTest.mockNetworkURL,
    ConstantsTest.mockNetworkURL
  ]);
  final mockScenario4 = createRocketEntity(
      name:
          'Tempor anim proident non ipsum nostrud in.Aliqua aliquip anim Lorem eiusmod ullamco.Ex cupidatat anim labore cupidatat cupidatat aliqua minim quis Lorem anim eu magna.');
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
                rocket: mockScenario1,
              ),
              name: 'empty image',
              onCreate: (scenarioWidgetKey) async {
                final imageWidget = find.descendant(
                  of: find.byKey(scenarioWidgetKey),
                  matching: find.byWidgetPredicate((widget) => widget is Image),
                );

                final nameWidget = find.descendant(
                  of: find.byKey(scenarioWidgetKey),
                  matching: find.textContaining(mockScenario1.name),
                );

                final companyWidget = find.descendant(
                  of: find.byKey(scenarioWidgetKey),
                  matching: find.textContaining(mockScenario1.company),
                );

                final descriptionWidget = find.descendant(
                  of: find.byKey(scenarioWidgetKey),
                  matching: find.text(mockScenario1.description),
                );

                expect(imageWidget, findsNothing);

                expect(nameWidget, findsOneWidget);
                expect(companyWidget, findsOneWidget);
                expect(descriptionWidget, findsOneWidget);
              },
            )
            ..addScenario(
              widget: widgetUnderTest(
                rocket: mockScenario2,
              ),
              name: 'list placeholder image',
              onCreate: (scenarioWidgetKey) async {
                final imageWidget = find.descendant(
                  of: find.byKey(scenarioWidgetKey),
                  matching: find.byWidgetPredicate((widget) =>
                      widget is Image && widget.image is AssetImage),
                );

                final nameWidget = find.descendant(
                  of: find.byKey(scenarioWidgetKey),
                  matching: find.textContaining(mockScenario2.name),
                );

                final companyWidget = find.descendant(
                  of: find.byKey(scenarioWidgetKey),
                  matching: find.textContaining(mockScenario2.company),
                );

                final descriptionWidget = find.descendant(
                  of: find.byKey(scenarioWidgetKey),
                  matching: find.text(mockScenario2.description),
                );

                expect(imageWidget, findsAtLeastNWidgets(1));
                expect(nameWidget, findsOneWidget);
                expect(companyWidget, findsOneWidget);
                expect(descriptionWidget, findsOneWidget);
              },
            )
            ..addScenario(
              widget: widgetUnderTest(
                rocket: mockScenario3,
              ),
              name: 'list network image',
              onCreate: (scenarioWidgetKey) async {
                final imageWidget = find.descendant(
                  of: find.byKey(scenarioWidgetKey),
                  matching: find.byWidgetPredicate((widget) =>
                      widget is Image && widget.image is NetworkImage),
                );

                final nameWidget = find.descendant(
                  of: find.byKey(scenarioWidgetKey),
                  matching: find.textContaining(mockScenario3.name),
                );

                final companyWidget = find.descendant(
                  of: find.byKey(scenarioWidgetKey),
                  matching: find.textContaining(mockScenario3.company),
                );

                final descriptionWidget = find.descendant(
                  of: find.byKey(scenarioWidgetKey),
                  matching: find.text(mockScenario3.description),
                );

                final matchExactUrl = find.descendant(
                  of: find.byKey(scenarioWidgetKey),
                  matching: find.widgetWithImage(RocketSection,
                      const NetworkImage(ConstantsTest.mockNetworkURL)),
                );

                expect(imageWidget, findsAtLeastNWidgets(1));
                expect(matchExactUrl, findsOneWidget);
                expect(nameWidget, findsOneWidget);
                expect(companyWidget, findsOneWidget);
                expect(descriptionWidget, findsOneWidget);
              },
            )
            ..addScenario(
              widget: widgetUnderTest(rocket: mockScenario4),
              name: 'a long name was given',
              onCreate: (scenarioWidgetKey) async {
                final imageWidget = find.descendant(
                  of: find.byKey(scenarioWidgetKey),
                  matching: find.byWidgetPredicate((widget) => widget is Image),
                );
                final nameWidget = find.descendant(
                  of: find.byKey(scenarioWidgetKey),
                  matching: find.textContaining(mockScenario4.name),
                );

                final companyWidget = find.descendant(
                  of: find.byKey(scenarioWidgetKey),
                  matching: find.textContaining(mockScenario4.company),
                );

                final descriptionWidget = find.descendant(
                  of: find.byKey(scenarioWidgetKey),
                  matching: find.text(mockScenario4.description),
                );

                expect(imageWidget, findsNothing);

                expect(nameWidget, findsOneWidget);
                expect(companyWidget, findsOneWidget);
                expect(descriptionWidget, findsOneWidget);
              },
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
