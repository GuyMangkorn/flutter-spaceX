import 'package:equatable/equatable.dart';

class PaginationDataModel extends Equatable {
  final int page;
  final bool hasNextPage;
  const PaginationDataModel({
    required this.hasNextPage,
    required this.page,
  });

  factory PaginationDataModel.fromJson(Map<String, dynamic> json) {
    return PaginationDataModel(
      hasNextPage: json['hasNextPage'] ?? false,
      page: json['page'],
    );
  }

  @override
  List<Object?> get props => [
        hasNextPage,
        page,
      ];
}
