part of 'launch_detail_bloc.dart';

enum LaunchDetailStatus { initial, loading, success, failure }

class LaunchDetailState extends Equatable {
  const LaunchDetailState({
    this.status = LaunchDetailStatus.initial,
    this.detail = const [],
    this.errorMessage = '',
  });

  final LaunchDetailStatus status;
  final List<LaunchDetailEntity> detail;
  final String errorMessage;

  LaunchDetailState copyWith({
    LaunchDetailStatus Function()? status,
    List<LaunchDetailEntity> Function()? detail,
    String Function()? errorMessage,
  }) {
    return LaunchDetailState(
      status: status != null ? status() : this.status,
      detail: detail != null ? detail() : this.detail,
      errorMessage: errorMessage != null ? errorMessage() : this.errorMessage,
    );
  }

  @override
  List<Object> get props => [
        status,
        detail,
        errorMessage,
      ];
}