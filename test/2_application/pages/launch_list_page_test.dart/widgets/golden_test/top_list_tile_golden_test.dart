import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:space_x_demo/2_application/pages/launch_list_page/widgets/top_list_tile.dart';

import '../../../../../../test_utils/test_utils.dart';

abstract class OnCustomButtonTap {
  void call();
}

class MockOnCustomButtonTap extends Mock implements OnCustomButtonTap {}

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
    final mockOnTab = MockOnCustomButtonTap();
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
            onCreate: (scenarioWidgetKey) async {
              final placeholder = find.descendant(
                of: find.byKey(scenarioWidgetKey),
                matching: find.byWidgetPredicate(
                  (widget) => widget is Image && widget.image is AssetImage,
                ),
              );

              final titleWidget = find.descendant(
                of: find.byKey(scenarioWidgetKey),
                matching: find.text('name_test'),
              );

              final dateWidget = find.descendant(
                of: find.byKey(scenarioWidgetKey),
                matching: find.text('date_test'),
              );

              expect(titleWidget, findsOneWidget);
              expect(dateWidget, findsOneWidget);
              expect(placeholder, findsOneWidget);
            },
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
              onCreate: (scenarioWidgetKey) async {
                final titleWidget = find.descendant(
                  of: find.byKey(scenarioWidgetKey),
                  matching: find.textContaining(
                      'name_test Labore enim ea ipsum enim nisi incididunt duis est exercitation ea mollit quis incididunt tempor.'),
                );

                final placeholderWidget = find.descendant(
                  of: find.byKey(scenarioWidgetKey),
                  matching: find.byWidgetPredicate((widget) =>
                      widget is Image && widget.image is AssetImage),
                );
                final dateWidget = find.descendant(
                  of: find.byKey(scenarioWidgetKey),
                  matching: find.textContaining(
                      'date_test Non dolore reprehenderit qui excepteur ut culpa voluptate.'),
                );

                expect(placeholderWidget, findsOneWidget);
                expect(titleWidget, findsOneWidget);
                expect(dateWidget, findsOneWidget);
              })
          ..addScenario(
            widget: widgetUnderTest(
              name: 'name_test',
              id: 'id',
              date: 'date_test',
              onTap: mockOnTab,
              images: [ConstantsTest.mockNetworkURL],
            ),
            name: 'network image',
            onCreate: (scenarioWidgetKey) async {
              final networkImage = find.descendant(
                of: find.byKey(scenarioWidgetKey),
                matching: find.byWidgetPredicate(
                  (widget) => widget is Image && widget.image is NetworkImage,
                ),
              );

              final titleWidget = find.descendant(
                of: find.byKey(scenarioWidgetKey),
                matching: find.text('name_test'),
              );

              final dateWidget = find.descendant(
                of: find.byKey(scenarioWidgetKey),
                matching: find.textContaining(
                  'date_test',
                ),
              );

              final tileWidget = find.descendant(
                of: find.byKey(scenarioWidgetKey),
                matching: find.byType(TopListItem),
              );

              final matchExactUrl = find.descendant(
                of: find.byKey(scenarioWidgetKey),
                matching: find.widgetWithImage(TopListItem,
                    const NetworkImage(ConstantsTest.mockNetworkURL)),
              );

              await tester.tap(tileWidget);

              expect(matchExactUrl, findsOneWidget);
              expect(networkImage, findsOneWidget);
              expect(dateWidget, findsOneWidget);
              expect(titleWidget, findsOneWidget);
              verify(mockOnTab.call).called(1);
            },
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
