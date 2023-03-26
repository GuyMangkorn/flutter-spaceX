import 'package:equatable/equatable.dart';
import 'package:space_x_demo/1_domain/entities/launch_entity.dart';
import 'package:space_x_demo/1_domain/entities/pagination_data_entity.dart';

class LaunchResponseEntity extends Equatable {
  const LaunchResponseEntity({
    required this.list,
    this.paginationData = const PaginationDataEntity(
      hasNextPage: false,
      page: 1,
    ),
  });

  final List<LaunchEntity> list;
  final PaginationDataEntity? paginationData;

  @override
  List<Object?> get props => [
        list,
        paginationData,
      ];
}
