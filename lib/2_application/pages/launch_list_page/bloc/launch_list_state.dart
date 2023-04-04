part of 'launch_list_bloc.dart';

enum LaunchListStatus { initial, loading, success, failure, refresh }

class LaunchListState extends Equatable {
  final LaunchListStatus status;
  final List<LaunchModel> list;
  final String errorMessage;
  final PaginationDataModel paginationData;
  final FilterModel filter;

  const LaunchListState({
    this.status = LaunchListStatus.initial,
    this.list = const [],
    this.errorMessage = '',
    this.paginationData = const PaginationDataModel(
      hasNextPage: false,
      page: 1,
    ),
    this.filter = const FilterModel(),
  });

  LaunchListState copyWith(
      {LaunchListStatus Function()? status,
      List<LaunchModel> Function()? list,
      String Function()? errorMessage,
      PaginationDataModel Function()? paginationData,
      FilterModel Function()? filter}) {
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
