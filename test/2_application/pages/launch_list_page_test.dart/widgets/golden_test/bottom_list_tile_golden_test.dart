import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:space_x_demo/2_application/pages/launch_list_page/widgets/bottom_list_tile.dart';
import 'package:space_x_demo/generated/l10n.dart';

import '../../../../../../test_utils/test_utils.dart';

abstract class OnCustomButtonTap {
  void call();
}

class MockOnCustomButtonTap extends Mock implements OnCustomButtonTap {}

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
      body: ListView(children: [
        BottomListTile(
          id: id,
          name: name,
          date: date,
          onTap: onTap,
          images: images,
          intl: S(),
          isSuccess: isSuccess,
        ),
      ]),
    );
  }

  group('BottomListTile golden', () {
    final mockOnTab = MockOnCustomButtonTap();

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
              onCreate: (scenarioWidgetKey) async {
                final nameWidget = find.descendant(
                  of: find.byKey(scenarioWidgetKey),
                  matching: find.text('test_name'),
                );
                final dateWidget = find.descendant(
                  of: find.byKey(scenarioWidgetKey),
                  matching: find.text('12-12-2022'),
                );
                final isSuccess = find.descendant(
                  of: find.byKey(scenarioWidgetKey),
                  matching: find.textContaining(S().success),
                );

                final placeholderWidget = find.descendant(
                  of: find.byKey(scenarioWidgetKey),
                  matching: find.byWidgetPredicate((widget) =>
                      widget is Image && widget.image is AssetImage),
                );

                expect(nameWidget, findsOneWidget);
                expect(dateWidget, findsOneWidget);
                expect(isSuccess, findsOneWidget);
                expect(placeholderWidget, findsOneWidget);
              },
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
                isSuccess: false,
              ),
              name: 'longe text with placeholder',
              onCreate: (scenarioWidgetKey) async {
                final nameWidget = find.descendant(
                  of: find.byKey(scenarioWidgetKey),
                  matching: find.textContaining(
                      'test_name Quis sit deserunt aliquip consectetur ad aliquip commodo.Ad consequat deserunt ipsum laboris.'),
                );

                final dateWidget = find.descendant(
                  of: find.byKey(scenarioWidgetKey),
                  matching: find.textContaining(
                      '12-12-2022 Mollit tempor culpa magna nostrud voluptate et occaecat.'),
                );

                final isSuccess = find.descendant(
                  of: find.byKey(scenarioWidgetKey),
                  matching: find.textContaining(S().failure),
                );

                final placeholderWidget = find.descendant(
                  of: find.byKey(scenarioWidgetKey),
                  matching: find.byWidgetPredicate((widget) =>
                      widget is Image && widget.image is AssetImage),
                );

                expect(nameWidget, findsOneWidget);
                expect(dateWidget, findsOneWidget);
                expect(isSuccess, findsOneWidget);
                expect(placeholderWidget, findsOneWidget);
              },
            )
            ..addScenario(
              widget: widgetUnderTest(
                id: 'id',
                name: 'test_name',
                date: '12-12-2022',
                onTap: mockOnTab,
                images: [ConstantsTest.mockNetworkURL],
                isSuccess: true,
              ),
              name: 'normal text with network image',
              onCreate: (scenarioWidgetKey) async {
                final nameWidget = find.descendant(
                  of: find.byKey(scenarioWidgetKey),
                  matching: find.text('test_name'),
                );
                final dateWidget = find.descendant(
                  of: find.byKey(scenarioWidgetKey),
                  matching: find.text('12-12-2022'),
                );
                final isSuccess = find.descendant(
                  of: find.byKey(scenarioWidgetKey),
                  matching: find.textContaining(S().success),
                );

                final networkImageWidget = find.descendant(
                  of: find.byKey(scenarioWidgetKey),
                  matching: find.byWidgetPredicate((widget) =>
                      widget is Image && widget.image is NetworkImage),
                );

                final matchExactImageUrl = find.descendant(
                  of: find.byKey(scenarioWidgetKey),
                  matching: find.widgetWithImage(
                    BottomListTile,
                    const NetworkImage(ConstantsTest.mockNetworkURL),
                  ),
                );

                final tileWidget = find.descendant(
                  of: find.byKey(scenarioWidgetKey),
                  matching: find.byType(BottomListTile),
                );

                await tester.tap(tileWidget);

                expect(matchExactImageUrl, findsOneWidget);
                expect(nameWidget, findsOneWidget);
                expect(dateWidget, findsOneWidget);
                expect(isSuccess, findsOneWidget);
                expect(networkImageWidget, findsOneWidget);
                verify(mockOnTab.call).called(1);
              },
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
