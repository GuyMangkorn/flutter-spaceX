part of 'launch_list_bloc.dart';

enum LaunchListStatus { initial, loading, success, failure, refresh }

class LaunchListState extends Equatable {
  final LaunchListStatus status;
  final List<LaunchEntity> list;
  final String errorMessage;
  final PaginationDataEntity paginationData;
  final FilterEntity filter;

  const LaunchListState({
    this.status = LaunchListStatus.initial,
    this.list = const [],
    this.errorMessage = '',
    this.paginationData = const PaginationDataEntity(
      hasNextPage: false,
      page: 1,
    ),
    this.filter = const FilterEntity(),
  });

  LaunchListState copyWith(
      {LaunchListStatus Function()? status,
      List<LaunchEntity> Function()? list,
      String Function()? errorMessage,
      PaginationDataEntity Function()? paginationData,
      FilterEntity Function()? filter}) {
    return LaunchListState(
      status: status != null ? status() : this.status,
      list: list != null ? list() : this.list,
      errorMessage: errorMessage != null ? errorMessage() : this.errorMessage,
      paginationData:
          paginationData != null ? paginationData() : this.paginationData,
      filter: filter != null ? filter() : this.filter,
    );
  }

  @override
  List<Object?> get props => [
        status,
        errorMessage,
        list,
        paginationData,
        filter,
      ];
}
