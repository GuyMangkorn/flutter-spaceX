import 'package:dartz/dartz.dart';
import 'package:space_x_demo/0_data/datasources/launch_remote_datasource.dart';
import 'package:space_x_demo/0_data/exceptions/exceptions.dart';
import 'package:space_x_demo/1_domain/entities/launch_detail_entity.dart';
import 'package:space_x_demo/1_domain/entities/launch_entity.dart';
import 'package:space_x_demo/1_domain/entities/launch_response_entity.dart';
import 'package:space_x_demo/1_domain/failure/failures.dart';
import 'package:space_x_demo/1_domain/repositories/launch_repo.dart';

class LaunchRepositoryImpl implements LaunchRepository {
  final LaunchRemoteDataSource launchRemoteDataSource;

  LaunchRepositoryImpl({required this.launchRemoteDataSource});

  @override
  Future<Either<List<LaunchEntity>, Failure>> fetchListLaunch() async {
    try {
      final result = await launchRemoteDataSource.fetchAllLaunch();
      return left(result);
    } on ServerException {
      return right(ServerFailure());
    } on BadRequestException {
      return right(BadRequestFailure());
    } catch (e) {
      return right(GeneralFailure());
    }
  }

  @override
  Future<Either<LaunchResponseEntity, Failure>> fetchListLaunchQuery(
      Map<String, dynamic> payload) async {
    try {
      final result = await launchRemoteDataSource.fetchQueryAllLaunch(payload);
      return left(result);
    } on ServerException {
      return right(ServerFailure());
    } on BadRequestException {
      return right(BadRequestFailure());
    } catch (e) {
      return right(GeneralFailure());
    }
  }

  @override
  Future<Either<LaunchDetailEntity, Failure>> fetchLaunchWithId(
      {required Map<String, dynamic> payload}) async {
    try {
      final result =
          await launchRemoteDataSource.fetchQueryOneLaunch(payload: payload);
      return left(result);
    } on ServerException {
      return right(ServerFailure());
    } on BadRequestException {
      return right(BadRequestFailure());
    } catch (e) {
      return right(GeneralFailure());
    }
  }
}
