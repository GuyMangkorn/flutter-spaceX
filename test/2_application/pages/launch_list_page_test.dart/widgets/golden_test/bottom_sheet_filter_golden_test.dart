import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:mocktail/mocktail.dart';
import 'package:space_x_demo/0_data/models/filter_model.dart';
import 'package:space_x_demo/2_application/pages/launch_list_page/bloc/launch_list_bloc.dart';
import 'package:space_x_demo/2_application/pages/launch_list_page/widgets/bottom_sheet_filter.dart';
import 'package:space_x_demo/generated/l10n.dart';

import '../../../../../../test_utils/test_utils.dart';

class MockLaunchListBloc extends Mock implements LaunchListBloc {}

void main() {
  late LaunchListBloc mockBloc;

  Widget widgetUnderTest({required LaunchListBloc bloc}) {
    return BlocProvider(
      create: (context) => bloc,
      child: Scaffold(
        body: BottomSheetFilter(bloc: bloc),
      ),
    );
  }

  setUpAll(() {
    mockBloc = MockLaunchListBloc();
  });

  group('BottomSheetFilter golden', () {
    testGoldens('should be displayed correctly', (tester) async {
      final builder = DeviceBuilder()
        ..overrideDevicesForAllScenarios(devices: [
          Device.iphone11,
          Device.tabletPortrait,
        ])
        ..addScenario(
          widget: Builder(builder: (context) {
            whenListen(
              mockBloc,
              Stream.fromIterable(const [
                LaunchListState(
                  filter: FilterModel(
                    filterByDate: false,
                    filterByName: true,
                    filterFlag: 1,
                  ),
                ),
              ]),
              initialState: const LaunchListState(),
            );
            return widgetUnderTest(bloc: mockBloc);
          }),
          name: 'sorting A-Z [true,false]',
          onCreate: (scenarioWidgetKey) async {
            final toggleButtons = find.descendant(
              of: find.byKey(scenarioWidgetKey),
              matching: find.byKey(const Key('t1')),
            );

            final labelName = find.descendant(
              of: find.byKey(scenarioWidgetKey),
              matching: find.text(S().by_name),
            );

            final toggleButtonDateIsSelected =
                tester.widget<ToggleButtons>(toggleButtons).isSelected;

            final headerIcon = find.descendant(
              of: find.byKey(scenarioWidgetKey),
              matching:
                  find.widgetWithIcon(BottomSheetFilter, Icons.filter_alt),
            );

            final headerLabel = find.descendant(
              of: find.byKey(scenarioWidgetKey),
              matching: find.text(S().filter),
            );

            expect(headerLabel, findsOneWidget);
            expect(headerIcon, findsOneWidget);
            expect(labelName, findsOneWidget);
            expect(toggleButtons, findsOneWidget);
            expect(toggleButtonDateIsSelected, [true, false]);
          },
        )
        ..addScenario(
          widget: Builder(builder: (context) {
            whenListen(
              mockBloc,
              Stream.fromIterable(const [
                LaunchListState(
                  filter: FilterModel(
                    filterByDate: false,
                    filterByName: true,
                    filterFlag: -1,
                  ),
                ),
              ]),
              initialState: const LaunchListState(),
            );
            return widgetUnderTest(bloc: mockBloc);
          }),
          name: 'sorting Z-A [false, true]',
          onCreate: (scenarioWidgetKey) async {
            final toggleButtons = find.descendant(
              of: find.byKey(scenarioWidgetKey),
              matching: find.byKey(const Key('t1')),
            );

            final labelName = find.descendant(
              of: find.byKey(scenarioWidgetKey),
              matching: find.text(S().by_name),
            );

            final toggleButtonDateIsSelected =
                tester.widget<ToggleButtons>(toggleButtons).isSelected;

            expect(labelName, findsOneWidget);
            expect(toggleButtons, findsOneWidget);
            expect(toggleButtonDateIsSelected, [false, true]);
          },
        )
        ..addScenario(
          widget: Builder(builder: (context) {
            whenListen(
              mockBloc,
              Stream.fromIterable(const [
                LaunchListState(
                  filter: FilterModel(
                    filterByDate: true,
                    filterByName: false,
                    filterFlag: -1,
                  ),
                ),
              ]),
              initialState: const LaunchListState(),
            );
            return widgetUnderTest(bloc: mockBloc);
          }),
          name: 'sorting Newer [true ,false]',
          onCreate: (scenarioWidgetKey) async {
            final toggleButtons = find.descendant(
              of: find.byKey(scenarioWidgetKey),
              matching: find.byKey(const Key('t2')),
            );

            final toggleButtonDateIsSelected =
                tester.widget<ToggleButtons>(toggleButtons).isSelected;

            final labelName = find.descendant(
              of: find.byKey(scenarioWidgetKey),
              matching: find.text(S().by_launch_date),
            );

            expect(labelName, findsOneWidget);
            expect(toggleButtons, findsOneWidget);
            expect(toggleButtonDateIsSelected, [true, false]);
          },
        )
        ..addScenario(
          widget: Builder(builder: (context) {
            whenListen(
              mockBloc,
              Stream.fromIterable(const [
                LaunchListState(
                  filter: FilterModel(
                    filterByDate: true,
                    filterByName: false,
                    filterFlag: 1,
                  ),
                ),
              ]),
              initialState: const LaunchListState(),
            );
            return widgetUnderTest(bloc: mockBloc);
          }),
          name: 'sorting Older [false,true]',
          onCreate: (scenarioWidgetKey) async {
            final toggleButtons = find.descendant(
              of: find.byKey(scenarioWidgetKey),
              matching: find.byKey(const Key('t2')),
            );

            final toggleButtonDateIsSelected =
                tester.widget<ToggleButtons>(toggleButtons).isSelected;

            final labelName = find.descendant(
              of: find.byKey(scenarioWidgetKey),
              matching: find.text(S().by_launch_date),
            );

            expect(labelName, findsOneWidget);
            expect(toggleButtons, findsOneWidget);
            expect(toggleButtonDateIsSelected, [false, true]);
          },
        );

      await pumpDeviceBuilderWithThemeWrapper(
        tester: tester,
        deviceBuilder: builder,
      );
      await screenMatchesGolden(
        tester,
        'bottom_sheet_filter',
      );
    });
  });
}
