import 'package:equatable/equatable.dart';

class PaginationDataEntity extends Equatable {
  final int page;
  final bool hasNextPage;
  const PaginationDataEntity({
    required this.hasNextPage,
    required this.page,
  });

  @override
  List<Object?> get props => [
        hasNextPage,
        page,
      ];
}
