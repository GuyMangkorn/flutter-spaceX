import 'package:equatable/equatable.dart';
import 'package:space_x_demo/0_data/models/launch_model.dart';
import 'package:space_x_demo/0_data/models/pagination_data_model.dart';
import 'package:space_x_demo/1_domain/entities/launch_response_entity.dart';

class LaunchResponseModel extends LaunchResponseEntity with EquatableMixin {
  LaunchResponseModel({required super.list, super.paginationData});

  factory LaunchResponseModel.fromJson(Map<String, dynamic> json) {
    return LaunchResponseModel(
      list: LaunchModel.fromListJson(json['docs'] ?? {}),
      paginationData: PaginationDataModel.fromJson(json),
    );
  }
}
