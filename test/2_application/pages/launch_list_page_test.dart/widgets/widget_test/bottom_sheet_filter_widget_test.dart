import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:space_x_demo/0_data/models/filter_model.dart';
import 'package:space_x_demo/0_data/repositories/launch_repository.dart';
import 'package:space_x_demo/2_application/pages/launch_list_page/bloc/launch_list_bloc.dart';
import 'package:space_x_demo/2_application/pages/launch_list_page/widgets/bottom_sheet_filter.dart';
import 'package:space_x_demo/generated/l10n.dart';

class MockLaunchRepository extends Mock implements LaunchRepositoryImpl {}

class MockLaunchListBloc extends Mock implements LaunchListBloc {}

void main() {
  late LaunchListBloc mockBloc;
  Widget widgetUnderTest({required LaunchListBloc launchListBloc}) {
    return BlocProvider(
      create: (context) => launchListBloc,
      child: MaterialApp(
        home: BottomSheetFilter(bloc: launchListBloc),
        locale: const Locale('en'),
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
      ),
    );
  }

  group('BottomSheetFilter', () {
    setUp(() {
      mockBloc = MockLaunchListBloc();
      whenListen(
        mockBloc,
        Stream.fromIterable(const [LaunchListState()]),
        initialState: const LaunchListState(),
      );
    });
    group('should be displayed correctly', () {
      testWidgets('when doesn\'t have an interactions', (widgetTester) async {
        await widgetTester
            .pumpWidget(widgetUnderTest(launchListBloc: mockBloc));
        await widgetTester.pumpAndSettle();

        final headerFilter = find.text(S().filter);
        final iconFilter = find.byIcon(Icons.filter_alt);

        expect(headerFilter, findsOneWidget);
        expect(iconFilter, findsOneWidget);

        final nameLabel = find.text(S().by_name);
        final dateLabel = find.text(S().by_launch_date);

        expect(nameLabel, findsOneWidget);
        expect(dateLabel, findsOneWidget);

        final toggleButtonsName = find.byKey(const Key('t1'));
        final toggleButtonsDate = find.byKey(const Key('t2'));

        expect(toggleButtonsDate, findsOneWidget);
        expect(toggleButtonsName, findsOneWidget);

        final toggleButtonDateChildren =
            widgetTester.widget<ToggleButtons>(toggleButtonsDate).children;
        final toggleButtonNameChildren =
            widgetTester.widget<ToggleButtons>(toggleButtonsName).children;

        expect(toggleButtonNameChildren.length, 2);
        expect(toggleButtonDateChildren.length, 2);
      });

      testWidgets(
        'when bloc state true on filter name and sort from A-Z [true, false]',
        (widgetTester) async {
          whenListen(
            mockBloc,
            Stream.fromIterable(const [
              LaunchListState(
                filter: FilterModel(
                    filterByDate: false, filterByName: true, filterFlag: 1),
              ),
            ]),
            initialState: const LaunchListState(),
          );
          await widgetTester
              .pumpWidget(widgetUnderTest(launchListBloc: mockBloc));
          await widgetTester.pumpAndSettle();

          final toggleButtonsName = find.byKey(const Key('t1'));
          expect(toggleButtonsName, findsOneWidget);

          final toggleButtonDateIsSelected =
              widgetTester.widget<ToggleButtons>(toggleButtonsName).isSelected;

          expect(toggleButtonDateIsSelected, [true, false]);
        },
      );

      testWidgets(
        'when bloc state true on filter date and sort from Older [false, true]',
        (widgetTester) async {
          whenListen(
            mockBloc,
            Stream.fromIterable(const [
              LaunchListState(
                filter: FilterModel(
                    filterByDate: true, filterByName: false, filterFlag: 1),
              ),
            ]),
            initialState: const LaunchListState(),
          );
          await widgetTester
              .pumpWidget(widgetUnderTest(launchListBloc: mockBloc));
          await widgetTester.pumpAndSettle();

          final toggleButtonsName = find.byKey(const Key('t2'));
          expect(toggleButtonsName, findsOneWidget);

          final toggleButtonDateIsSelected =
              widgetTester.widget<ToggleButtons>(toggleButtonsName).isSelected;

          expect(toggleButtonDateIsSelected, [false, true]);
        },
      );
    });
  });
}
