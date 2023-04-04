part of 'launch_upcoming_list_bloc.dart';

enum LaunchUpcomingListStatus { initial, loading, success, failure }

class LaunchUpcomingListState extends Equatable {
  const LaunchUpcomingListState({
    this.status = LaunchUpcomingListStatus.initial,
    this.list = const [],
    this.errorMessage = '',
  });

  final LaunchUpcomingListStatus status;
  final List<LaunchModel> list;
  final String errorMessage;

  LaunchUpcomingListState copyWith({
    LaunchUpcomingListStatus Function()? status,
    List<LaunchModel> Function()? list,
    String Function()? errorMessage,
  }) {
    return LaunchUpcomingListState(
      status: status != null ? status() : this.status,
      list: list != null ? list() : this.list,
      errorMessage: errorMessage != null ? errorMessage() : this.errorMessage,
    );
  }

  @override
  List<Object> get props => [
        status,
        list,
        errorMessage,
      ];
}
