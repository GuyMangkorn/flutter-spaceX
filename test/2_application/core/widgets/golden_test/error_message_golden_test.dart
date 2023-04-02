import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:space_x_demo/2_application/core/widgets/error_message.dart';

import '../../../../../test_utils/test_utils.dart';

// # Run all tests.
// * flutter test

// # Only run golden tests.
// * flutter test --tags golden

// # Run all tests except golden tests.
// * flutter test --exclude-tags golden

void main() {
  Widget widgetUnderTest({required String message}) {
    return Scaffold(
      body: ErrorMessage(message: message),
    );
  }

  group('ErrorMessage golden', () {
    testGoldens(
      'should be displayed correctly in different devices',
      (tester) async {
        final builder = DeviceBuilder()
          ..overrideDevicesForAllScenarios(devices: [
            Device.iphone11,
            Device.phone,
            const Device(
              name: '300 x 300',
              size: Size(300, 300),
            ),
          ])
          ..addScenario(
            widget: widgetUnderTest(
              message: 'error_message',
            ),
            name: 'normal text',
            onCreate: (scenarioWidgetKey) async {
              final findText = find.descendant(
                of: find.byKey(scenarioWidgetKey),
                matching: find.text('error_message'),
              );

              final iconWidget = find.descendant(
                of: find.byKey(scenarioWidgetKey),
                matching: find.byIcon(Icons.warning_amber_rounded),
              );

              expect(findText, findsOneWidget);
              expect(iconWidget, findsOneWidget);
            },
          )
          ..addScenario(
            widget: widgetUnderTest(
              message:
                  'Culpa veniam eiusmod anim esse adipisicing minim esse deserunt reprehenderit cupidatat deserunt.Laboris qui magna elit occaecat.',
            ),
            name: 'long message',
            onCreate: (scenarioWidgetKey) async {
              final findText = find.descendant(
                of: find.byKey(scenarioWidgetKey),
                matching: find.textContaining(
                    'Culpa veniam eiusmod anim esse adipisicing minim esse deserunt reprehenderit cupidatat deserunt.Laboris qui magna elit occaecat.'),
              );

              final iconWidget = find.descendant(
                of: find.byKey(scenarioWidgetKey),
                matching: find.byIcon(Icons.warning_amber_rounded),
              );

              expect(findText, findsOneWidget);
              expect(iconWidget, findsOneWidget);
            },
          )
          ..addScenario(
            widget: widgetUnderTest(message: ''),
            name: 'no message',
            onCreate: (scenarioWidgetKey) async {
              final findText = find.descendant(
                of: find.byKey(scenarioWidgetKey),
                matching: find.text('error_message'),
              );

              final iconWidget = find.descendant(
                of: find.byKey(scenarioWidgetKey),
                matching: find.byIcon(Icons.warning_amber_rounded),
              );

              expect(findText, findsNothing);
              expect(iconWidget, findsOneWidget);
            },
          );

        await pumpDeviceBuilderWithThemeWrapper(
            tester: tester, deviceBuilder: builder);
        await screenMatchesGolden(tester, 'error_message');
      },
    );
  });
}
