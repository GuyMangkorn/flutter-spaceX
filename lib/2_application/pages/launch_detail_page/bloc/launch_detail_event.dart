part of 'launch_detail_bloc.dart';

abstract class LaunchDetailEvent extends Equatable {
  const LaunchDetailEvent();

  @override
  List<Object> get props => [];
}

class LaunchDetailRequested extends LaunchDetailEvent {
  final String id;
  const LaunchDetailRequested({required this.id});
}
