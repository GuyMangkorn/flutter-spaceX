import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:space_x_demo/0_data/models/crew_model.dart';
import 'package:space_x_demo/0_data/models/launch_detail_model.dart';
import 'package:space_x_demo/0_data/models/launchpad_model.dart';
import 'package:space_x_demo/0_data/models/rocket_model.dart';
import 'package:space_x_demo/2_application/core/widgets/error_message.dart';
import 'package:space_x_demo/2_application/pages/launch_detail_page/bloc/launch_detail_bloc.dart';
import 'package:space_x_demo/2_application/pages/launch_detail_page/launch_detail_page.dart';
import 'package:space_x_demo/2_application/pages/launch_detail_page/widgets/crews_section.dart';
import 'package:space_x_demo/2_application/pages/launch_detail_page/widgets/launchpad_section.dart';
import 'package:space_x_demo/2_application/pages/launch_detail_page/widgets/rocket_section.dart';
import 'package:space_x_demo/2_application/pages/launch_detail_page/widgets/skeleton_detail_page.dart';
import 'package:space_x_demo/2_application/routes/argument_model/launch_detail_argument.dart';
import 'package:space_x_demo/constants/mock_constants.dart';
import 'package:space_x_demo/generated/l10n.dart';
import 'package:space_x_demo/utils/failure/failures.dart';

class MockLaunchDetailBloc
    extends MockBloc<LaunchDetailEvent, LaunchDetailState>
    implements LaunchDetailBloc {}

void main() {
  const mockLaunchDetail = LaunchDetailModel(
    dateUtc: 'dateUtc',
    id: 'id',
    name: 'name',
    success: true,
    upcoming: false,
    details: 'details',
    article: 'article',
    wikipedia: 'wikipedia',
    crew: [
      CrewModel(
          id: 'id',
          name: 'name',
          agency: 'agency',
          image: '',
          wikipedia: 'wikipedia',
          status: 'status')
    ],
    rocket: RocketModel(
        id: 'id',
        name: 'name',
        images: [],
        successRatePct: 69,
        country: 'country',
        company: 'company',
        description: 'description'),
    launchpad: LaunchpadModel(
      id: 'id',
      name: 'name',
      fullName: 'fullName',
      locality: 'locality',
      region: 'region',
      launchAttempts: 55,
      launchSuccesses: 55,
      details: 'details',
      image: [],
    ),
  );

  LaunchDetailArgument createSubject({
    String id = 'id',
    String name = 'name',
    String image = '',
  }) {
    return LaunchDetailArgument(
      id: id,
      name: name,
      image: image,
    );
  }

  Widget widgetUnderTest({
    required LaunchDetailBloc bloc,
    required LaunchDetailArgument args,
  }) {
    return MaterialApp(
      locale: const Locale('en'),
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      home: BlocProvider(
        create: (context) => bloc..add(LaunchDetailRequested(id: args.id)),
        child: LaunchDetailPage(args: args),
      ),
    );
  }

  group('LaunchDetailPage', () {
    late LaunchDetailBloc mockLaunchDetailBloc;
    late LaunchDetailArgument mockLaunchDetailArgument;

    setUp(() {
      mockLaunchDetailBloc = MockLaunchDetailBloc();
      mockLaunchDetailArgument = createSubject();
      whenListen(
        mockLaunchDetailBloc,
        Stream.fromIterable(
            const [LaunchDetailState(status: LaunchDetailStatus.initial)]),
        initialState:
            const LaunchDetailState(status: LaunchDetailStatus.initial),
      );
    });

    group('should be displayed correctly', () {
      testWidgets('when name and image from args are given',
          (widgetTester) async {
        const title = 'test_name';
        mockLaunchDetailArgument = createSubject(
          name: title,
          image: MockConstants.mockNetworkURL,
        );

        await mockNetworkImagesFor(
          () async => await widgetTester.pumpWidget(widgetUnderTest(
            bloc: mockLaunchDetailBloc,
            args: mockLaunchDetailArgument,
          )),
        );
        await widgetTester.pump(const Duration(milliseconds: 500));

        final titleWidget = find.textContaining(title);
        final imageWidget = find.byWidgetPredicate(
            (widget) => widget is Image && widget.image is NetworkImage);

        expect(titleWidget, findsAtLeastNWidgets(1));
        expect(imageWidget, findsOneWidget);
      });

      testWidgets('when long name and no image from args are given',
          (widgetTester) async {
        const title =
            'test_name Culpa dolore veniam officia fugiat magna est.Voluptate proident occaecat qui proident enim duis mollit elit in.';
        mockLaunchDetailArgument = createSubject(
          name: title,
          image: '',
        );

        await widgetTester.pumpWidget(widgetUnderTest(
          bloc: mockLaunchDetailBloc,
          args: mockLaunchDetailArgument,
        ));
        await widgetTester.pump(const Duration(milliseconds: 500));

        final titleWidget = find.textContaining(title);
        final placeholderWidget = find.byWidgetPredicate(
            (widget) => widget is Image && widget.image is AssetImage);

        expect(titleWidget, findsAtLeastNWidgets(1));
        expect(placeholderWidget, findsOneWidget);
      });

      testWidgets('when bloc state was loading', (widgetTester) async {
        whenListen(
          mockLaunchDetailBloc,
          Stream.fromIterable(
              const [LaunchDetailState(status: LaunchDetailStatus.loading)]),
          initialState:
              const LaunchDetailState(status: LaunchDetailStatus.initial),
        );
        await widgetTester.pumpWidget(widgetUnderTest(
          bloc: mockLaunchDetailBloc,
          args: mockLaunchDetailArgument,
        ));
        await widgetTester.pump(const Duration(milliseconds: 500));

        final skeletonWidget = find.byType(SkeletonDetailPage);
        expect(skeletonWidget, findsOneWidget);
      });

      testWidgets('when bloc state was failure', (widgetTester) async {
        whenListen(
          mockLaunchDetailBloc,
          Stream.fromIterable(const [
            LaunchDetailState(
              status: LaunchDetailStatus.failure,
              errorMessage: serverFailureMessage,
            )
          ]),
          initialState:
              const LaunchDetailState(status: LaunchDetailStatus.initial),
        );
        await widgetTester.pumpWidget(widgetUnderTest(
          bloc: mockLaunchDetailBloc,
          args: mockLaunchDetailArgument,
        ));
        await widgetTester.pump(const Duration(milliseconds: 500));
        // * for animated ErrorMessage
        await widgetTester.pump(const Duration(milliseconds: 500));

        final skeletonWidget = find.byType(ErrorMessage);
        final errorMessage = find.text(serverFailureMessage);
        expect(skeletonWidget, findsOneWidget);
        expect(errorMessage, findsOneWidget);
      });

      testWidgets('when bloc state was success with data',
          (widgetTester) async {
        whenListen(
          mockLaunchDetailBloc,
          Stream.fromIterable([
            const LaunchDetailState(
              status: LaunchDetailStatus.success,
              detail: [mockLaunchDetail],
            )
          ]),
          initialState: const LaunchDetailState(
            status: LaunchDetailStatus.initial,
          ),
        );

        await widgetTester.pumpWidget(widgetUnderTest(
          bloc: mockLaunchDetailBloc,
          args: mockLaunchDetailArgument,
        ));
        await widgetTester.pump(const Duration(milliseconds: 500));

        final rocketSection = find.byType(RocketSection);
        final crewSection = find.byType(CrewsSection);
        final launchpadSection = find.byType(LaunchpadSection);

        expect(rocketSection, findsOneWidget);
        expect(crewSection, findsOneWidget);
        expect(launchpadSection, findsOneWidget);

        final rocketParams =
            widgetTester.widget<RocketSection>(rocketSection).rocket;
        final crewParams = widgetTester.widget<CrewsSection>(crewSection).crews;
        final launchpadParams =
            widgetTester.widget<LaunchpadSection>(launchpadSection).launchpad;

        expect(rocketParams, mockLaunchDetail.rocket);
        expect(crewParams, mockLaunchDetail.crew);
        expect(launchpadParams, mockLaunchDetail.launchpad);
      });
    });
  });
}
