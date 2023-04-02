import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:mocktail/mocktail.dart';
import 'package:space_x_demo/1_domain/entities/filter_entity.dart';
import 'package:space_x_demo/2_application/pages/launch_list_page/bloc/launch_list_bloc.dart';
import 'package:space_x_demo/2_application/pages/launch_list_page/widgets/bottom_sheet_filter.dart';

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
                  filter: FilterEntity(
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
          name: 'sorting A-Z',
        )
        ..addScenario(
          widget: Builder(builder: (context) {
            whenListen(
              mockBloc,
              Stream.fromIterable(const [
                LaunchListState(
                  filter: FilterEntity(
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
          name: 'sorting Z-A',
        )
        ..addScenario(
          widget: Builder(builder: (context) {
            whenListen(
              mockBloc,
              Stream.fromIterable(const [
                LaunchListState(
                  filter: FilterEntity(
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
          name: 'sorting Newer',
        )
        ..addScenario(
          widget: Builder(builder: (context) {
            whenListen(
              mockBloc,
              Stream.fromIterable(const [
                LaunchListState(
                  filter: FilterEntity(
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
          name: 'sorting Older',
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
