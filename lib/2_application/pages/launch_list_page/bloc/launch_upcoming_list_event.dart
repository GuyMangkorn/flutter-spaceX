part of 'launch_upcoming_list_bloc.dart';

abstract class LaunchUpcomingListEvent extends Equatable {
  const LaunchUpcomingListEvent();

  @override
  List<Object> get props => [];
}

class LaunchUpcomingListRequested extends LaunchUpcomingListEvent {}
