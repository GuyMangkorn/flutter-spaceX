import 'package:equatable/equatable.dart';
import 'package:space_x_demo/0_data/models/launch_model.dart';
import 'package:space_x_demo/0_data/models/pagination_data_model.dart';

class LaunchResponseModel extends Equatable {
  final List<LaunchModel> list;
  final PaginationDataModel? paginationData;

  const LaunchResponseModel({
    required this.list,
    this.paginationData = const PaginationDataModel(
      hasNextPage: false,
      page: 1,
    ),
  });

  factory LaunchResponseModel.fromJson(Map<String, dynamic> json) {
    return LaunchResponseModel(
      list: LaunchModel.fromListJson(json['docs'] ?? {}),
      paginationData: PaginationDataModel.fromJson(json),
    );
  }

  @override
  List<Object?> get props => [
        list,
        paginationData,
      ];
}
