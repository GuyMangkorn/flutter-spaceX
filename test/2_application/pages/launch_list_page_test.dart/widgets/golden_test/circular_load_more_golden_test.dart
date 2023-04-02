import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:space_x_demo/2_application/pages/launch_list_page/widgets/circular_load_more.dart';

import '../../../../../../test_utils/test_utils.dart';

void main() {
  group('CircularLoadMore golden', () {
    Widget widgetUnderTest({required String message}) {
      return Scaffold(
        body: CircularLoadMore(loadMoreText: message),
      );
    }

    testGoldens('should be displayed correctly', (tester) async {
      final builder = DeviceBuilder()
        ..overrideDevicesForAllScenarios(
            devices: [Device.iphone11, Device.tabletPortrait])
        ..addScenario(
          widget: widgetUnderTest(
            message: 'Loading...',
          ),
          name: 'normal text',
          onCreate: (scenarioWidgetKey) async {
            final circleLoading = find.descendant(
              of: find.byKey(scenarioWidgetKey),
              matching: find.byType(CircularProgressIndicator),
            );

            final loadMessage = find.descendant(
              of: find.byKey(scenarioWidgetKey),
              matching: find.text('Loading...'),
            );

            expect(circleLoading, findsOneWidget);
            expect(loadMessage, findsOneWidget);
          },
        )
        ..addScenario(
          widget: widgetUnderTest(
            message:
                'Loading Incididunt eiusmod consequat labore duis do culpa velit dolore est qui excepteur est....',
          ),
          name: 'long text',
          onCreate: (scenarioWidgetKey) async {
            final circleLoading = find.descendant(
              of: find.byKey(scenarioWidgetKey),
              matching: find.byType(CircularProgressIndicator),
            );

            final loadMessage = find.descendant(
              of: find.byKey(scenarioWidgetKey),
              matching: find.textContaining(
                  'Loading Incididunt eiusmod consequat labore duis do culpa velit dolore est qui excepteur est....'),
            );

            expect(circleLoading, findsOneWidget);
            expect(loadMessage, findsOneWidget);
          },
        );

      await pumpDeviceBuilderWithThemeWrapper(
          tester: tester, deviceBuilder: builder);
      await screenMatchesGolden(tester, 'circular_load_more', customPump: (p0) {
        return tester.pump(const Duration(milliseconds: 500));
      });
    });
  });
}
