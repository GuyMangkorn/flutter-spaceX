import 'dart:math';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:space_x_demo/0_data/models/launch_model.dart';
import 'package:space_x_demo/2_application/core/widgets/error_message.dart';
import 'package:space_x_demo/2_application/pages/launch_list_page/bloc/launch_list_bloc.dart';
import 'package:space_x_demo/2_application/pages/launch_list_page/bloc/launch_upcoming_list_bloc.dart';
import 'package:space_x_demo/2_application/pages/launch_list_page/launch_list_page.dart';
import 'package:space_x_demo/2_application/pages/launch_list_page/widgets/bottom_list_section.dart';
import 'package:space_x_demo/2_application/pages/launch_list_page/widgets/circular_load_more.dart';
import 'package:space_x_demo/2_application/pages/launch_list_page/widgets/skeleton_bottom_list.dart';
import 'package:space_x_demo/2_application/pages/launch_list_page/widgets/skeleton_top_list.dart';
import 'package:space_x_demo/2_application/pages/launch_list_page/widgets/top_list_section.dart';
import 'package:space_x_demo/generated/l10n.dart';
import 'package:space_x_demo/utils/failure/failures.dart';

class MockLaunchListBloc extends MockBloc<LaunchListEvent, LaunchListState>
    implements LaunchListBloc {}

class MockLaunchUpcomingListBloc
    extends MockBloc<LaunchUpcomingListEvent, LaunchUpcomingListState>
    implements LaunchUpcomingListBloc {}

const mockLength = 5;
void main() {
  final mockResponse = List.generate(
    mockLength,
    (index) => LaunchModel(
      dateUtc: 'dateUtc',
      id: 'id',
      name: 'name$index',
      success: true,
      upcoming: false,
      images: const [],
      patch: 'patch',
    ),
  );
  Widget widgetUnderTest(
      {required LaunchListBloc bloc,
      required LaunchUpcomingListBloc upcomingBloc}) {
    return MaterialApp(
      locale: const Locale('en'),
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => bloc..add(LaunchListRequested()),
          ),
          BlocProvider(
            create: (context) =>
                upcomingBloc..add(LaunchUpcomingListRequested()),
          ),
        ],
        child: const LaunchListPage(),
      ),
    );
  }

  group('LaunchListPage', () {
    late LaunchListBloc mockLaunchListBloc;
    late LaunchUpcomingListBloc mockLaunchUpcomingListBloc;

    setUp(() {
      mockLaunchListBloc = MockLaunchListBloc();
      mockLaunchUpcomingListBloc = MockLaunchUpcomingListBloc();
    });
    group('should be displayed', () {
      testWidgets('skeleton when bloc emit initial state',
          (widgetTester) async {
        whenListen(
            mockLaunchListBloc, Stream.fromIterable(const [LaunchListState()]),
            initialState: const LaunchListState());
        whenListen(mockLaunchUpcomingListBloc,
            Stream.fromIterable(const [LaunchUpcomingListState()]),
            initialState: const LaunchUpcomingListState());

        await widgetTester.pumpWidget(widgetUnderTest(
          bloc: mockLaunchListBloc,
          upcomingBloc: mockLaunchUpcomingListBloc,
        ));
        await widgetTester.pump(const Duration(milliseconds: 500));

        final bottomSkeleton = find.byType(SkeletonBottomList);
        final topSkeleton = find.byType(SkeletonTopList);

        expect(topSkeleton, findsOneWidget);
        expect(bottomSkeleton, findsOneWidget);
      });

      testWidgets('skeleton when 2 bloc emit loading state',
          (widgetTester) async {
        whenListen(
            mockLaunchListBloc,
            Stream.fromIterable(
                const [LaunchListState(status: LaunchListStatus.loading)]),
            initialState: const LaunchListState());
        whenListen(
            mockLaunchUpcomingListBloc,
            Stream.fromIterable(const [
              LaunchUpcomingListState(status: LaunchUpcomingListStatus.loading)
            ]),
            initialState: const LaunchUpcomingListState());

        await widgetTester.pumpWidget(widgetUnderTest(
          bloc: mockLaunchListBloc,
          upcomingBloc: mockLaunchUpcomingListBloc,
        ));
        await widgetTester.pump(const Duration(milliseconds: 500));

        final bottomSkeleton = find.byType(SkeletonBottomList);
        final topSkeleton = find.byType(SkeletonTopList);

        expect(topSkeleton, findsOneWidget);
        expect(bottomSkeleton, findsOneWidget);
      });

      testWidgets('top and bottom list when 2 bloc emit success',
          (widgetTester) async {
        whenListen(
          mockLaunchListBloc,
          Stream.fromIterable([
            LaunchListState(
              status: LaunchListStatus.success,
              list: mockResponse,
            )
          ]),
          initialState: const LaunchListState(),
        );
        whenListen(
          mockLaunchUpcomingListBloc,
          Stream.fromIterable([
            LaunchUpcomingListState(
              status: LaunchUpcomingListStatus.success,
              list: mockResponse,
            )
          ]),
          initialState: const LaunchUpcomingListState(),
        );

        await widgetTester.pumpWidget(widgetUnderTest(
          bloc: mockLaunchListBloc,
          upcomingBloc: mockLaunchUpcomingListBloc,
        ));
        await widgetTester.pump(const Duration(milliseconds: 500));

        final topListWidget = find.byType(TopListSection);
        final bottomListWIdget = find.byType(BottomListSection);
        expect(topListWidget, findsOneWidget);
        expect(bottomListWIdget, findsOneWidget);

        final listInTopSection = widgetTester
            .widget<TopListSection>(find.byType(TopListSection))
            .listData;
        final listInBottomSection = widgetTester
            .widget<BottomListSection>(find.byType(BottomListSection))
            .listData;

        expect(listInTopSection, equals(mockResponse));
        expect(listInBottomSection, equals(mockResponse));
      });

      testWidgets('error message widget when 2 bloc emit failure',
          (widgetTester) async {
        whenListen(
          mockLaunchListBloc,
          Stream.fromIterable([
            const LaunchListState(
              status: LaunchListStatus.failure,
              errorMessage: generalFailureMessage,
            ),
          ]),
          initialState: const LaunchListState(status: LaunchListStatus.initial),
        );
        whenListen(
          mockLaunchUpcomingListBloc,
          Stream.fromIterable([
            const LaunchUpcomingListState(
              status: LaunchUpcomingListStatus.failure,
              errorMessage: generalFailureMessage,
            ),
          ]),
          initialState: const LaunchUpcomingListState(
              status: LaunchUpcomingListStatus.initial),
        );

        await widgetTester.pumpWidget(widgetUnderTest(
          bloc: mockLaunchListBloc,
          upcomingBloc: mockLaunchUpcomingListBloc,
        ));

        // * Pump FadeIn in LaunchListScreen
        await widgetTester.pump(const Duration(milliseconds: 500));
        // * Pump ElasticIn in first ErrorMessage
        await widgetTester.pump(const Duration(milliseconds: 500));
        // * Pump ElasticIn in second ErrorMessage
        await widgetTester.pump(const Duration(milliseconds: 500));

        final errorMessageWidget = find.byType(ErrorMessage);
        final generalMessage = find.textContaining(generalFailureMessage);

        expect(errorMessageWidget, findsAtLeastNWidgets(2));
        expect(generalMessage, findsAtLeastNWidgets(2));
      });

      testWidgets(
          'error message widget when 1 bloc emit failure and 1 bloc emit success',
          (widgetTester) async {
        whenListen(
          mockLaunchListBloc,
          Stream.fromIterable([
            const LaunchListState(
              status: LaunchListStatus.failure,
              errorMessage: serverFailureMessage,
            ),
          ]),
          initialState: const LaunchListState(status: LaunchListStatus.initial),
        );
        whenListen(
          mockLaunchUpcomingListBloc,
          Stream.fromIterable([
            LaunchUpcomingListState(
              status: LaunchUpcomingListStatus.success,
              list: mockResponse,
            ),
          ]),
          initialState: const LaunchUpcomingListState(
              status: LaunchUpcomingListStatus.initial),
        );

        await widgetTester.pumpWidget(widgetUnderTest(
          bloc: mockLaunchListBloc,
          upcomingBloc: mockLaunchUpcomingListBloc,
        ));

        // * Pump FadeIn in LaunchListScreen
        await widgetTester.pump(const Duration(milliseconds: 500));
        // * Pump ElasticIn in ErrorMessage
        await widgetTester.pump(const Duration(milliseconds: 500));

        final errorMessageWidget = find.byType(ErrorMessage);
        final generalMessage = find.textContaining(serverFailureMessage);

        expect(errorMessageWidget, findsOneWidget);
        expect(generalMessage, findsOneWidget);

        final topListWidget = find.byType(TopListSection);
        expect(topListWidget, findsOneWidget);
      });

      testWidgets(
          'error message widget when 1 bloc emit failure and 1 bloc emit loading',
          (widgetTester) async {
        whenListen(
          mockLaunchListBloc,
          Stream.fromIterable([
            const LaunchListState(
              status: LaunchListStatus.failure,
              errorMessage: serverFailureMessage,
            ),
          ]),
          initialState: const LaunchListState(status: LaunchListStatus.initial),
        );
        whenListen(
          mockLaunchUpcomingListBloc,
          Stream.fromIterable([
            const LaunchUpcomingListState(
              status: LaunchUpcomingListStatus.loading,
            ),
          ]),
          initialState: const LaunchUpcomingListState(
              status: LaunchUpcomingListStatus.initial),
        );

        await widgetTester.pumpWidget(widgetUnderTest(
          bloc: mockLaunchListBloc,
          upcomingBloc: mockLaunchUpcomingListBloc,
        ));

        // * Pump FadeIn in LaunchListScreen
        await widgetTester.pump(const Duration(milliseconds: 500));
        // * Pump ElasticIn in ErrorMessage
        await widgetTester.pump(const Duration(milliseconds: 500));

        final errorMessageWidget = find.byType(ErrorMessage);
        final generalMessage = find.textContaining(serverFailureMessage);

        expect(errorMessageWidget, findsOneWidget);
        expect(generalMessage, findsOneWidget);

        final topListWidget = find.byType(SkeletonTopList);
        expect(topListWidget, findsOneWidget);
      });

      testWidgets('loading bottom when bottom bloc emit refresh',
          (widgetTester) async {
        whenListen(
          mockLaunchListBloc,
          Stream.fromIterable([
            const LaunchListState(
              status: LaunchListStatus.refresh,
              errorMessage: serverFailureMessage,
            ),
          ]),
          initialState: const LaunchListState(status: LaunchListStatus.initial),
        );
        whenListen(
          mockLaunchUpcomingListBloc,
          Stream.fromIterable([
            const LaunchUpcomingListState(
              status: LaunchUpcomingListStatus.success,
            ),
          ]),
          initialState: const LaunchUpcomingListState(
            status: LaunchUpcomingListStatus.initial,
          ),
        );

        await widgetTester.pumpWidget(widgetUnderTest(
          bloc: mockLaunchListBloc,
          upcomingBloc: mockLaunchUpcomingListBloc,
        ));

        // * Pump FadeIn in LaunchListScreen
        await widgetTester.pump(const Duration(milliseconds: 500));

        final loadMoreIndicator = find.byType(CircularLoadMore);
        expect(loadMoreIndicator, findsOneWidget);
      });
    });
  });
}
