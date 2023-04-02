import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:space_x_demo/2_application/core/widgets/custom_card.dart';
import 'package:space_x_demo/constants/constants.dart';

import '../../../../../test_utils/test_utils.dart';

void main() {
  Widget widgetUnderTest({required Widget child}) {
    return Scaffold(
      body: CustomCard(
        child: child,
      ),
    );
  }

  group('CustomCard golden', () {
    testGoldens(
      'should be displayed correctly',
      (tester) async {
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
            widget: widgetUnderTest(
              child: const Center(child: Text('Title')),
            ),
            name: 'with text child',
            onCreate: (scenarioWidgetKey) async {
              final childWidget = find.descendant(
                of: find.byKey(scenarioWidgetKey),
                matching: find.text('Title'),
              );

              expect(childWidget, findsOneWidget);
            },
          )
          ..addScenario(
            widget: Builder(builder: (context) {
              return widgetUnderTest(
                child: Column(children: [
                  Expanded(
                      child: Image.asset('assets/images/placeholder.jpeg')),
                  Text(
                    'Title',
                    style: Theme.of(context).textTheme.bodyLarge,
                  )
                ]),
              );
            }),
            name: 'with image child',
            onCreate: (scenarioWidgetKey) async {
              final childWidget = find.descendant(
                of: find.byKey(scenarioWidgetKey),
                matching: find.byType(Image),
              );

              expect(childWidget, findsOneWidget);
            },
          );

        await pumpDeviceBuilderWithThemeWrapper(
            tester: tester, deviceBuilder: builder);
        await screenMatchesGolden(tester, 'custom_card');
      },
    );
  });
}
