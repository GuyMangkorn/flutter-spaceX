import 'package:equatable/equatable.dart';
import 'package:space_x_demo/1_domain/entities/pagination_data_entity.dart';

class PaginationDataModel extends PaginationDataEntity with EquatableMixin {
  PaginationDataModel({required super.hasNextPage, required super.page});

  factory PaginationDataModel.fromJson(Map<String, dynamic> json) {
    return PaginationDataModel(
      hasNextPage: json['hasNextPage'] ?? false,
      page: json['page'],
    );
  }
}
