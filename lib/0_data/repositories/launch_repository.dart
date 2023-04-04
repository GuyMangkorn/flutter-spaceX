import 'package:dartz/dartz.dart';
import 'package:space_x_demo/0_data/datasources/launch_remote_datasource.dart';
import 'package:space_x_demo/0_data/exceptions/exceptions.dart';
import 'package:space_x_demo/0_data/models/launch_detail_model.dart';
import 'package:space_x_demo/0_data/models/launch_model.dart';
import 'package:space_x_demo/0_data/models/launch_response_model.dart';
import 'package:space_x_demo/utils/failure/failures.dart';

abstract class LaunchRepository {
  Future<Either<List<LaunchModel>, Failure>> fetchListLaunch();
  Future<Either<LaunchResponseModel, Failure>> fetchListLaunchQuery(
      Map<String, dynamic> payload);
  Future<Either<LaunchDetailModel, Failure>> fetchLaunchWithId(
      {required Map<String, dynamic> payload});
}

class LaunchRepositoryImpl implements LaunchRepository {
  final LaunchRemoteDataSource launchRemoteDataSource;

  LaunchRepositoryImpl({required this.launchRemoteDataSource});

  @override
  Future<Either<List<LaunchModel>, Failure>> fetchListLaunch() async {
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
  Future<Either<LaunchResponseModel, Failure>> fetchListLaunchQuery(
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
  Future<Either<LaunchDetailModel, Failure>> fetchLaunchWithId(
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
