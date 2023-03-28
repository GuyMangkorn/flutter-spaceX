import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:space_x_demo/0_data/datasources/launch_remote_datasource.dart';
import 'package:space_x_demo/0_data/exceptions/exceptions.dart';
import 'package:space_x_demo/0_data/models/crew_model.dart';
import 'package:space_x_demo/0_data/models/launch_detail_model.dart';
import 'package:space_x_demo/0_data/models/launch_model.dart';
import 'package:space_x_demo/0_data/models/launch_response_model.dart';
import 'package:space_x_demo/0_data/models/launchpad_model.dart';
import 'package:space_x_demo/0_data/models/pagination_data_model.dart';
import 'package:space_x_demo/0_data/models/rocket_model.dart';
import 'package:space_x_demo/0_data/repositories/launch_repo_impl.dart';
import 'package:space_x_demo/1_domain/entities/launch_response_entity.dart';
import 'package:space_x_demo/1_domain/failure/failures.dart';
import 'package:space_x_demo/1_domain/repositories/launch_repo.dart';

class MockLaunchRemoteDataSource extends Mock
    implements LaunchRemoteDataSourceImpl {}

void main() {
  final LaunchRemoteDataSource mockLaunchRemoteDataSource =
      MockLaunchRemoteDataSource();
  final LaunchRepository launchRepositoryUnderTest =
      LaunchRepositoryImpl(launchRemoteDataSource: mockLaunchRemoteDataSource);
  group('LaunchRepository', () {
    test(
        'should return left with LaunchResponseEntity when LaunchRemoteDataSource return LaunchResponseModel',
        () async {
      final Map<String, dynamic> payload = {};
      when(() => mockLaunchRemoteDataSource.fetchQueryAllLaunch(payload))
          .thenAnswer(
        (realInvocation) => Future.value(
          LaunchResponseModel(
            list: const <LaunchModel>[],
            paginationData: PaginationDataModel(hasNextPage: false, page: 1),
          ),
        ),
      );

      final response =
          await launchRepositoryUnderTest.fetchListLaunchQuery(payload);

      expect(response.isLeft(), true);
      expect(response.isRight(), false);
      expect(
        response,
        Left<LaunchResponseEntity, Failure>(
          LaunchResponseModel(
            list: const <LaunchModel>[],
            paginationData: PaginationDataModel(hasNextPage: false, page: 1),
          ),
        ),
      );

      verify(() => mockLaunchRemoteDataSource.fetchQueryAllLaunch(payload))
          .called(1);
      verifyNoMoreInteractions(mockLaunchRemoteDataSource);
    });

    test(
        'should return left with LaunchDetailEntity when LaunchRemoteDataSource return LaunchDetailModel',
        () async {
      final Map<String, dynamic> payload = {};

      when(() =>
              mockLaunchRemoteDataSource.fetchQueryOneLaunch(payload: payload))
          .thenAnswer(
        (invocation) => Future.value(
          LaunchDetailModel(
            id: 'test_id',
            name: 'test_name',
            dateUtc: 'test_date',
            success: true,
            upcoming: false,
            details: 'test_details',
            crew: const <CrewModel>[],
            rocket: RocketModel(
              id: 'test_id',
              name: 'test_name',
              images: const [],
              successRatePct: 99,
              country: 'test_country',
              company: 'test_company',
              description: 'test_desp',
            ),
            launchpad: LaunchpadModel(
              id: 'test_id',
              name: 'test_name',
              fullName: 'test_fullMame',
              locality: 'locality',
              region: 'region',
              launchAttempts: 55,
              launchSuccesses: 55,
              details: 'details',
              image: const [],
            ),
            article: 'test_article',
            wikipedia: 'test_wikipedia',
          ),
        ),
      );

      final response =
          await launchRepositoryUnderTest.fetchLaunchWithId(payload: payload);

      expect(response.isLeft(), true);
      expect(response.isRight(), false);
      expect(
        response,
        Left(
          LaunchDetailModel(
            id: 'test_id',
            name: 'test_name',
            dateUtc: 'test_date',
            success: true,
            upcoming: false,
            details: 'test_details',
            crew: const <CrewModel>[],
            rocket: RocketModel(
              id: 'test_id',
              name: 'test_name',
              images: const [],
              successRatePct: 99,
              country: 'test_country',
              company: 'test_company',
              description: 'test_desp',
            ),
            launchpad: LaunchpadModel(
              id: 'test_id',
              name: 'test_name',
              fullName: 'test_fullMame',
              locality: 'locality',
              region: 'region',
              launchAttempts: 55,
              launchSuccesses: 55,
              details: 'details',
              image: const [],
            ),
            article: 'test_article',
            wikipedia: 'test_wikipedia',
          ),
        ),
      );

      verify(() =>
              mockLaunchRemoteDataSource.fetchQueryOneLaunch(payload: payload))
          .called(1);
      verifyNoMoreInteractions(mockLaunchRemoteDataSource);
    });

    group('should return right with', () {
      const Map<String, dynamic> payload = {};
      test('a ServerFailure when ServerException occurs', () async {
        when(() => mockLaunchRemoteDataSource.fetchQueryAllLaunch(payload))
            .thenThrow(ServerException());

        final response =
            await launchRepositoryUnderTest.fetchListLaunchQuery(payload);

        expect(response.isRight(), true);
        expect(response.isLeft(), false);
        expect(response, Right<LaunchResponseEntity, Failure>(ServerFailure()));
      });

      test('a GeneralFailure when FetchDataException occurs', () async {
        when(() => mockLaunchRemoteDataSource.fetchQueryAllLaunch(payload))
            .thenThrow(FetchDataException());

        final response =
            await launchRepositoryUnderTest.fetchListLaunchQuery(payload);

        expect(response.isRight(), true);
        expect(response.isLeft(), false);
        expect(
            response, Right<LaunchResponseEntity, Failure>(GeneralFailure()));
      });

      test('a BadRequestFailure when BadRequestException occurs', () async {
        when(() => mockLaunchRemoteDataSource.fetchQueryAllLaunch(payload))
            .thenThrow(BadRequestException());

        final response =
            await launchRepositoryUnderTest.fetchListLaunchQuery(payload);

        expect(response.isRight(), true);
        expect(response.isLeft(), false);
        expect(response,
            Right<LaunchResponseEntity, Failure>(BadRequestFailure()));
      });
    });
  });
}
