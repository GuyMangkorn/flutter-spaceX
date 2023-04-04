import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:space_x_demo/0_data/models/filter_model.dart';
import 'package:space_x_demo/0_data/models/launch_model.dart';
import 'package:space_x_demo/0_data/models/launch_response_model.dart';
import 'package:space_x_demo/0_data/models/pagination_data_model.dart';
import 'package:space_x_demo/0_data/repositories/launch_repository.dart';
import 'package:space_x_demo/2_application/pages/launch_list_page/bloc/launch_list_bloc.dart';
import 'package:space_x_demo/utils/failure/failures.dart';

class MockLaunchRepository extends Mock implements LaunchRepositoryImpl {}

class FakeLaunchEntity extends Fake implements LaunchModel {}

void main() {
  late LaunchRepository mockLaunchRepository;
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
  late Map<String, dynamic> payload;
  late dynamic sort;

  setUpAll(() {
    mockLaunchRepository = MockLaunchRepository();
    registerFallbackValue(Left([FakeLaunchEntity()]));
  });

  LaunchListBloc buildBloc() {
    return LaunchListBloc(launchRepository: mockLaunchRepository);
  }

  group('LaunchListBloc', () {
    group('should emits', () {
      blocTest(
        '[] when event wasn\'t added',
        build: buildBloc,
        expect: () => [],
      );

      group(
          '[LaunchListState(status: refresh),LaunchListState(status: success)]',
          () {
        blocTest(
          'when LaunchListLoadMoreRequested was added',
          setUp: () {
            sort = {"date_utc": -1};
            payload = {
              "query": {"upcoming": false},
              "options": {
                "limit": limitPerPage,
                "page": 2,
                "sort": sort,
              }
            };
            when(() => mockLaunchRepository.fetchListLaunchQuery(payload))
                .thenAnswer(
              (invocation) => Future.value(
                const Left(
                  LaunchResponseModel(
                    list: mockResponse,
                    paginationData:
                        PaginationDataModel(hasNextPage: true, page: 2),
                  ),
                ),
              ),
            );
          },
          seed: () => const LaunchListState(
            list: mockResponse,
            status: LaunchListStatus.success,
            paginationData: PaginationDataModel(hasNextPage: true, page: 1),
          ),
          build: buildBloc,
          act: (bloc) => bloc.add(LaunchListLoadMoreRequested()),
          expect: () => const <LaunchListState>[
            LaunchListState(
              list: mockResponse,
              status: LaunchListStatus.refresh,
              paginationData: PaginationDataModel(hasNextPage: true, page: 1),
            ),
            LaunchListState(
              list: [...mockResponse, ...mockResponse],
              status: LaunchListStatus.success,
              paginationData: PaginationDataModel(hasNextPage: true, page: 2),
            )
          ],
          verify: (_) {
            verify(() => mockLaunchRepository.fetchListLaunchQuery(payload))
                .called(1);
          },
        );
      });

      group(
          '[LaunchListState(status: loading),LaunchListState(status: success)]',
          () {
        blocTest(
          'when LaunchListRequested was added',
          setUp: () {
            sort = {"date_utc": -1};
            payload = {
              "query": {"upcoming": false},
              "options": {
                "limit": limitPerPage,
                "sort": sort,
              }
            };
            when(
              () => mockLaunchRepository.fetchListLaunchQuery(payload),
            ).thenAnswer(
              (invocation) => Future.value(const Left(LaunchResponseModel(
                list: mockResponse,
              ))),
            );
          },
          build: buildBloc,
          act: (bloc) => bloc.add(LaunchListRequested()),
          expect: () => const <LaunchListState>[
            LaunchListState(status: LaunchListStatus.loading),
            LaunchListState(
                list: mockResponse, status: LaunchListStatus.success),
          ],
        );

        blocTest(
          'when LaunchListFilterRequested was added',
          setUp: () {
            sort = {"name": 1};
            payload = payload = {
              "query": {"upcoming": false},
              "options": {
                "limit": limitPerPage,
                "sort": sort,
              }
            };
            when(() => mockLaunchRepository.fetchListLaunchQuery(payload))
                .thenAnswer(
              (invocation) => Future.value(
                const Left(LaunchResponseModel(list: mockResponse)),
              ),
            );
          },
          build: buildBloc,
          act: (bloc) => bloc.add(
            const LaunchListFilterRequested(
                filterByDate: false, filterByName: true, filterFlag: 1),
          ),
          expect: () => <LaunchListState>[
            const LaunchListState(
                status: LaunchListStatus.loading,
                filter: FilterModel(
                    filterByDate: false, filterByName: true, filterFlag: 1)),
            const LaunchListState(
              list: mockResponse,
              status: LaunchListStatus.success,
              filter: FilterModel(
                  filterByDate: false, filterByName: true, filterFlag: 1),
            )
          ],
        );

        blocTest(
          'when LaunchListSearchByTextRequested was added',
          setUp: () {
            sort = {"date_utc": -1};
            payload = {
              "query": {
                "name": {
                  "\$regex": "^test_search",
                  "\$options": "i",
                },
                "upcoming": false,
              },
              "options": {
                "limit": limitPerPage,
                "sort": sort,
              }
            };
            when(
              () => mockLaunchRepository.fetchListLaunchQuery(payload),
            ).thenAnswer(
              (invocation) => Future.value(
                const Left(LaunchResponseModel(
                    list: mockResponse,
                    paginationData:
                        PaginationDataModel(hasNextPage: true, page: 1))),
              ),
            );
          },
          build: buildBloc,
          act: (bloc) => bloc.add(
              const LaunchListSearchByTextRequested(textSearch: 'test_search')),
          expect: () => const <LaunchListState>[
            LaunchListState(status: LaunchListStatus.loading),
            LaunchListState(
              list: mockResponse,
              status: LaunchListStatus.success,
              paginationData: PaginationDataModel(hasNextPage: true, page: 1),
            ),
          ],
        );
      });

      group(
        '[LaunchListState(status: loading),LaunchListState(status: failure)]',
        () {
          group('when LaunchListRequested was added', () {
            setUp(() {
              sort = {"date_utc": -1};
              payload = {
                "query": {"upcoming": false},
                "options": {
                  "limit": limitPerPage,
                  "sort": sort,
                }
              };
            });

            blocTest(
              'and a ServerFailure occurs',
              setUp: () =>
                  when(() => mockLaunchRepository.fetchListLaunchQuery(payload))
                      .thenAnswer(
                          (invocation) => Future.value(Right(ServerFailure()))),
              build: buildBloc,
              act: (bloc) => bloc.add(LaunchListRequested()),
              expect: () => const <LaunchListState>[
                LaunchListState(status: LaunchListStatus.loading),
                LaunchListState(
                    status: LaunchListStatus.failure,
                    errorMessage: serverFailureMessage)
              ],
            );

            blocTest(
              'and a GeneralFailure occurs',
              setUp: () =>
                  when(() => mockLaunchRepository.fetchListLaunchQuery(payload))
                      .thenAnswer((invocation) =>
                          Future.value(Right(GeneralFailure()))),
              build: buildBloc,
              act: (bloc) => bloc.add(LaunchListRequested()),
              expect: () => const <LaunchListState>[
                LaunchListState(status: LaunchListStatus.loading),
                LaunchListState(
                    status: LaunchListStatus.failure,
                    errorMessage: generalFailureMessage)
              ],
            );

            blocTest(
              'and a BadRequestFailure occurs',
              setUp: () =>
                  when(() => mockLaunchRepository.fetchListLaunchQuery(payload))
                      .thenAnswer((invocation) =>
                          Future.value(Right(BadRequestFailure()))),
              build: buildBloc,
              act: (bloc) => bloc.add(LaunchListRequested()),
              expect: () => const <LaunchListState>[
                LaunchListState(status: LaunchListStatus.loading),
                LaunchListState(
                    status: LaunchListStatus.failure,
                    errorMessage: badRequestedFailureMessage)
              ],
            );
          });

          group('when LaunchListLoadMoreRequested was added', () {
            setUp(() {
              sort = {"date_utc": -1};
              payload = {
                "query": {"upcoming": false},
                "options": {
                  "limit": limitPerPage,
                  "page": 1,
                  "sort": sort,
                }
              };
            });

            blocTest(
              'and a ServerFailure occurs',
              setUp: () =>
                  when(() => mockLaunchRepository.fetchListLaunchQuery(payload))
                      .thenAnswer(
                (invocation) => Future.value(Right(ServerFailure())),
              ),
              build: buildBloc,
              act: (bloc) => bloc.add(LaunchListLoadMoreRequested()),
              expect: () => const [
                LaunchListState(status: LaunchListStatus.refresh),
                LaunchListState(
                  status: LaunchListStatus.failure,
                  errorMessage: serverFailureMessage,
                )
              ],
            );

            blocTest(
              'and a GeneralFailure occurs',
              setUp: () =>
                  when(() => mockLaunchRepository.fetchListLaunchQuery(payload))
                      .thenAnswer(
                (invocation) => Future.value(Right(GeneralFailure())),
              ),
              build: buildBloc,
              act: (bloc) => bloc.add(LaunchListLoadMoreRequested()),
              expect: () => const [
                LaunchListState(status: LaunchListStatus.refresh),
                LaunchListState(
                  status: LaunchListStatus.failure,
                  errorMessage: generalFailureMessage,
                )
              ],
            );

            blocTest(
              'and a BadRequestFailure occurs',
              setUp: () =>
                  when(() => mockLaunchRepository.fetchListLaunchQuery(payload))
                      .thenAnswer(
                (invocation) => Future.value(Right(BadRequestFailure())),
              ),
              build: buildBloc,
              act: (bloc) => bloc.add(LaunchListLoadMoreRequested()),
              expect: () => const [
                LaunchListState(status: LaunchListStatus.refresh),
                LaunchListState(
                  status: LaunchListStatus.failure,
                  errorMessage: badRequestedFailureMessage,
                )
              ],
            );
          });

          group('when LaunchListFilterRequested was added', () {
            setUp(() {
              sort = {"date_utc": -1};
              payload = {
                "query": {"upcoming": false},
                "options": {
                  "limit": limitPerPage,
                  "sort": sort,
                }
              };
            });

            blocTest(
              'and a ServerFailure occurs',
              setUp: () {
                when(() => mockLaunchRepository.fetchListLaunchQuery(payload))
                    .thenAnswer(
                        (invocation) => Future.value(Right(ServerFailure())));
              },
              build: buildBloc,
              act: (bloc) => bloc.add(const LaunchListFilterRequested()),
              expect: () => const [
                LaunchListState(status: LaunchListStatus.loading),
                LaunchListState(
                    status: LaunchListStatus.failure,
                    errorMessage: serverFailureMessage)
              ],
            );

            blocTest(
              'and a GeneralFailure occurs',
              setUp: () {
                when(() => mockLaunchRepository.fetchListLaunchQuery(payload))
                    .thenAnswer(
                        (invocation) => Future.value(Right(GeneralFailure())));
              },
              build: buildBloc,
              act: (bloc) => bloc.add(const LaunchListFilterRequested()),
              expect: () => const [
                LaunchListState(status: LaunchListStatus.loading),
                LaunchListState(
                    status: LaunchListStatus.failure,
                    errorMessage: generalFailureMessage)
              ],
            );

            blocTest(
              'and a BadRequestFailure occurs',
              setUp: () {
                when(() => mockLaunchRepository.fetchListLaunchQuery(payload))
                    .thenAnswer((invocation) =>
                        Future.value(Right(BadRequestFailure())));
              },
              build: buildBloc,
              act: (bloc) => bloc.add(const LaunchListFilterRequested()),
              expect: () => const [
                LaunchListState(status: LaunchListStatus.loading),
                LaunchListState(
                    status: LaunchListStatus.failure,
                    errorMessage: badRequestedFailureMessage)
              ],
            );
          });

          group('when LaunchListSearchByTextRequested was added', () {
            setUp(() {
              sort = {"date_utc": -1};
              payload = {
                "query": {
                  "name": {
                    "\$regex": "^test_name",
                    "\$options": "i",
                  },
                  "upcoming": false,
                },
                "options": {
                  "limit": limitPerPage,
                  "sort": sort,
                }
              };
            });

            blocTest(
              'and a ServerFailure occurs',
              setUp: () =>
                  when(() => mockLaunchRepository.fetchListLaunchQuery(payload))
                      .thenAnswer(
                          (invocation) => Future.value(Right(ServerFailure()))),
              build: buildBloc,
              act: (bloc) => bloc.add(const LaunchListSearchByTextRequested(
                  textSearch: 'test_name')),
              expect: () => const [
                LaunchListState(status: LaunchListStatus.loading),
                LaunchListState(
                    status: LaunchListStatus.failure,
                    errorMessage: serverFailureMessage)
              ],
            );

            blocTest(
              'and a GeneralFailure occurs',
              setUp: () =>
                  when(() => mockLaunchRepository.fetchListLaunchQuery(payload))
                      .thenAnswer((invocation) =>
                          Future.value(Right(GeneralFailure()))),
              build: buildBloc,
              act: (bloc) => bloc.add(const LaunchListSearchByTextRequested(
                  textSearch: 'test_name')),
              expect: () => const [
                LaunchListState(status: LaunchListStatus.loading),
                LaunchListState(
                    status: LaunchListStatus.failure,
                    errorMessage: generalFailureMessage)
              ],
            );

            blocTest(
              'and a BadRequestFailure occurs',
              setUp: () =>
                  when(() => mockLaunchRepository.fetchListLaunchQuery(payload))
                      .thenAnswer((invocation) =>
                          Future.value(Right(BadRequestFailure()))),
              build: buildBloc,
              act: (bloc) => bloc.add(const LaunchListSearchByTextRequested(
                  textSearch: 'test_name')),
              expect: () => const [
                LaunchListState(status: LaunchListStatus.loading),
                LaunchListState(
                    status: LaunchListStatus.failure,
                    errorMessage: badRequestedFailureMessage)
              ],
            );
          });
        },
      );
    });
  });
}
