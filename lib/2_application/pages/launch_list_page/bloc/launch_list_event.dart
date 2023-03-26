part of 'launch_list_bloc.dart';

@immutable
abstract class LaunchListEvent extends Equatable {
  const LaunchListEvent();
  @override
  List<Object?> get props => [];
}

class LaunchListRequested extends LaunchListEvent {}

class LaunchListLoadMoreRequested extends LaunchListEvent {}

class LaunchListFilterRequested extends LaunchListEvent {
  final bool filterByName;
  final bool filterByDate;
  final int filterFlag;
  const LaunchListFilterRequested({
    this.filterByDate = true,
    this.filterByName = false,
    this.filterFlag = -1,
  });
}

class LaunchListSearchByTextRequested extends LaunchListEvent {
  final String textSearch;

  const LaunchListSearchByTextRequested({
    required this.textSearch,
  });
}
