import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:space_x_demo/0_data/repositories/launch_repo_impl.dart';
import 'package:space_x_demo/1_domain/entities/launch_entity.dart';
import 'package:space_x_demo/1_domain/entities/launch_response_entity.dart';
import 'package:space_x_demo/1_domain/failure/failures.dart';
import 'package:space_x_demo/1_domain/repositories/launch_repo.dart';
import 'package:space_x_demo/2_application/pages/launch_list_page/bloc/launch_upcoming_list_bloc.dart';

class MockLaunchRepository extends Mock implements LaunchRepositoryImpl {}

class FakeLaunchEntity extends Fake implements LaunchEntity {}

void main() {
  late LaunchRepository mockLaunchRepository;
  late Map<String, dynamic> payload;

  const List<LaunchEntity> mockResponse = [
    LaunchEntity(
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
                const Left(LaunchResponseEntity(list: mockResponse)),
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
