import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:space_x_demo/0_data/models/crew_model.dart';
import 'package:space_x_demo/0_data/models/launch_detail_model.dart';
import 'package:space_x_demo/0_data/models/launchpad_model.dart';
import 'package:space_x_demo/0_data/models/rocket_model.dart';
import 'package:space_x_demo/0_data/repositories/launch_repository.dart';
import 'package:space_x_demo/2_application/pages/launch_detail_page/bloc/launch_detail_bloc.dart';
import 'package:space_x_demo/utils/failure/failures.dart';

class MockLaunchRepository extends Mock implements LaunchRepositoryImpl {}

class MockCrewEntity extends Mock implements CrewModel {}

class MockRocketEntity extends Mock implements RocketModel {}

class MockLaunchpadEntity extends Mock implements LaunchpadModel {}

void main() {
  final LaunchRepository mockLaunchRepository = MockLaunchRepository();
  final LaunchDetailModel mockResponse = LaunchDetailModel(
    dateUtc: 'dateUtc',
    id: 'id',
    name: 'name',
    success: true,
    upcoming: false,
    details: 'details',
    article: 'article',
    wikipedia: 'wikipedia',
    crew: [MockCrewEntity()],
    rocket: MockRocketEntity(),
    launchpad: MockLaunchpadEntity(),
  );

  LaunchDetailBloc buildBloc() {
    return LaunchDetailBloc(launchRepository: mockLaunchRepository);
  }

  group('LaunchDetailBloc', () {
    group('should emits', () {
      final Map<String, dynamic> payload = {
        "query": {"_id": 'test_id'},
        "options": {
          "populate": [
            {"path": "launchpad"},
            {"path": "crew"},
            {"path": "rocket"}
          ]
        }
      };

      blocTest(
        'nothings when event wasn\'t added',
        build: buildBloc,
        expect: () => <LaunchDetailState>[],
      );

      blocTest(
        '[LaunchDetailState(state:loading), LaunchDetailState(state:success)] when LaunchDetailRequestedEvent was added',
        setUp: () {
          when(
            () => mockLaunchRepository.fetchLaunchWithId(
              payload: payload,
            ),
          ).thenAnswer(
            (invocation) => Future.value(
              Left<LaunchDetailModel, Failure>(mockResponse),
            ),
          );
        },
        build: buildBloc,
        act: (bloc) => bloc.add(const LaunchDetailRequested(id: 'test_id')),
        expect: () => <LaunchDetailState>[
          const LaunchDetailState(
            status: LaunchDetailStatus.loading,
          ),
          LaunchDetailState(
            detail: [mockResponse],
            status: LaunchDetailStatus.success,
          ),
        ],
      );

      group(
          '[LaunchDetailState(state:loading), LaunchDetailState(state:failure)] when LaunchDetailRequestedEvent was added',
          () {
        blocTest(
          'and a ServerFailure occurs',
          setUp: () => when(
            () => mockLaunchRepository.fetchLaunchWithId(payload: payload),
          ).thenAnswer(
            (invocation) => Future.value(
              Right(ServerFailure()),
            ),
          ),
          build: buildBloc,
          act: (bloc) => bloc.add(const LaunchDetailRequested(id: 'test_id')),
          expect: () => <LaunchDetailState>[
            const LaunchDetailState(
              status: LaunchDetailStatus.loading,
            ),
            const LaunchDetailState(
              status: LaunchDetailStatus.failure,
              errorMessage: serverFailureMessage,
            )
          ],
        );

        blocTest(
          'and a GeneralFailure occurs',
          setUp: () => when(
            () => mockLaunchRepository.fetchLaunchWithId(payload: payload),
          ).thenAnswer(
            (invocation) => Future.value(
              Right(GeneralFailure()),
            ),
          ),
          build: buildBloc,
          act: (bloc) => bloc.add(const LaunchDetailRequested(id: 'test_id')),
          expect: () => <LaunchDetailState>[
            const LaunchDetailState(
              status: LaunchDetailStatus.loading,
            ),
            const LaunchDetailState(
              status: LaunchDetailStatus.failure,
              errorMessage: generalFailureMessage,
            )
          ],
        );

        blocTest(
          'and a BadRequestFailure occurs',
          setUp: () => when(
            () => mockLaunchRepository.fetchLaunchWithId(payload: payload),
          ).thenAnswer(
            (invocation) => Future.value(
              Right(BadRequestFailure()),
            ),
          ),
          build: buildBloc,
          act: (bloc) => bloc.add(const LaunchDetailRequested(id: 'test_id')),
          expect: () => <LaunchDetailState>[
            const LaunchDetailState(
              status: LaunchDetailStatus.loading,
            ),
            const LaunchDetailState(
              status: LaunchDetailStatus.failure,
              errorMessage: badRequestedFailureMessage,
            )
          ],
        );
      });
    });
  });
}
