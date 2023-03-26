import 'package:dartz/dartz.dart';
import 'package:http/http.dart';
import 'package:space_x_demo/1_domain/entities/launch_detail_entity.dart';
import 'package:space_x_demo/1_domain/entities/launch_entity.dart';
import 'package:space_x_demo/1_domain/entities/launch_response_entity.dart';
import 'package:space_x_demo/1_domain/failure/failures.dart';

abstract class LaunchRepository {
  Future<Either<List<LaunchEntity>, Failure>> fetchListLaunch();
  Future<Either<LaunchResponseEntity, Failure>> fetchListLaunchQuery(
      Map<String, dynamic> payload);
  Future<Either<LaunchDetailEntity, Failure>> fetchLaunchWithId(
      {required Map<String, dynamic> payload});
}
