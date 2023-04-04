import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:space_x_demo/0_data/models/launch_model.dart';
import 'package:space_x_demo/0_data/models/launch_response_model.dart';
import 'package:space_x_demo/0_data/repositories/launch_repository.dart';
import 'package:space_x_demo/2_application/pages/launch_list_page/bloc/launch_upcoming_list_bloc.dart';
import 'package:space_x_demo/utils/failure/failures.dart';

class MockLaunchRepository extends Mock implements LaunchRepositoryImpl {}

class FakeLaunchEntity extends Fake implements LaunchModel {}

void main() {
  late LaunchRepository mockLaunchRepository;
  late Map<String, dynamic> payload;

  const List<LaunchModel> mockResponse = [
    LaunchModel(
      dateUtc: 'dateUtc',
      id: 'id',
      name: 'name',
      success: true,
      upcoming: false,
      images: ['images'],
      patch: 'patch',
    )
  ];

  setUpAll(() {
    mockLaunchRepository = MockLaunchRepository();
    registerFallbackValue(Left([FakeLaunchEntity()]));
  });

  LaunchUpcomingListBloc buildBloc() {
    return LaunchUpcomingListBloc(launchRepository: mockLaunchRepository);
  }

  group('LaunchUpcomingListBloc', () {
    setUp(() {
      payload = {
        "query": {"upcoming": true},
        "options": {
          "limit": 20,
          "sort": {"date_utc": -1}
        }
      };
    });
    group('should emits', () {
      blocTest(
        '[] when event wasn\'t added',
        build: buildBloc,
        expect: () => [],
      );

      group(
          '[LaunchUpcomingListState(status: refresh),LaunchUpcomingListState(status: success)]',
          () {
        blocTest(
          'when LaunchUpcomingListRequested was added',
          setUp: () {
            when(() => mockLaunchRepository.fetchListLaunchQuery(payload))
                .thenAnswer(
              (invocation) => Future.value(
                const Left(LaunchResponseModel(list: mockResponse)),
              ),
            );
          },
          build: buildBloc,
          act: (bloc) => bloc.add(LaunchUpcomingListRequested()),
          expect: () => const [
            LaunchUpcomingListState(
              status: LaunchUpcomingListStatus.loading,
            ),
            LaunchUpcomingListState(
                status: LaunchUpcomingListStatus.success, list: mockResponse),
          ],
        );
      });

      group(
          '[LaunchUpcomingListState(status: refresh),LaunchUpcomingListState(status: failure)]',
          () {
        group('when LaunchUpcomingListRequested was added', () {
          blocTest(
            'and a ServerFailure occurs',
            setUp: () {
              when(() => mockLaunchRepository.fetchListLaunchQuery(payload))
                  .thenAnswer(
                (invocation) => Future.value(Right(ServerFailure())),
              );
            },
            build: buildBloc,
            act: (bloc) => bloc.add(LaunchUpcomingListRequested()),
            expect: () => const [
              LaunchUpcomingListState(status: LaunchUpcomingListStatus.loading),
              LaunchUpcomingListState(
                status: LaunchUpcomingListStatus.failure,
                errorMessage: serverFailureMessage,
              )
            ],
          );

          blocTest(
            'and a GeneralFailure occurs',
            setUp: () {
              when(() => mockLaunchRepository.fetchListLaunchQuery(payload))
                  .thenAnswer(
                (invocation) => Future.value(Right(GeneralFailure())),
              );
            },
            build: buildBloc,
            act: (bloc) => bloc.add(LaunchUpcomingListRequested()),
            expect: () => const [
              LaunchUpcomingListState(status: LaunchUpcomingListStatus.loading),
              LaunchUpcomingListState(
                status: LaunchUpcomingListStatus.failure,
                errorMessage: generalFailureMessage,
              )
            ],
          );

          blocTest(
            'and a BadRequestFailure occurs',
            setUp: () {
              when(() => mockLaunchRepository.fetchListLaunchQuery(payload))
                  .thenAnswer(
                (invocation) => Future.value(Right(BadRequestFailure())),
              );
            },
            build: buildBloc,
            act: (bloc) => bloc.add(LaunchUpcomingListRequested()),
            expect: () => const [
              LaunchUpcomingListState(status: LaunchUpcomingListStatus.loading),
              LaunchUpcomingListState(
                status: LaunchUpcomingListStatus.failure,
                errorMessage: badRequestedFailureMessage,
              )
            ],
          );
        });
      });
    });
  });
}
