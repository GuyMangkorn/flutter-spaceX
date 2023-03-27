import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_x_demo/1_domain/entities/launch_entity.dart';
import 'package:space_x_demo/1_domain/failure/failures.dart';
import 'package:space_x_demo/1_domain/repositories/launch_repo.dart';

part 'launch_upcoming_list_event.dart';
part 'launch_upcoming_list_state.dart';

class LaunchUpcomingListBloc
    extends Bloc<LaunchUpcomingListEvent, LaunchUpcomingListState> {
  final LaunchRepository launchRepository;

  LaunchUpcomingListBloc({required this.launchRepository})
      : super(const LaunchUpcomingListState()) {
    on<LaunchUpcomingListRequested>(_onLaunchUpcomingListRequestedHandler);
  }

  Future<void> _onLaunchUpcomingListRequestedHandler(
    LaunchUpcomingListRequested event,
    Emitter<LaunchUpcomingListState> emit,
  ) async {
    emit(state.copyWith(status: () => LaunchUpcomingListStatus.loading));

    final Map<String, dynamic> payload = {
      "query": {"upcoming": true},
      "options": {
        "limit": 20,
        "sort": {"date_utc": -1}
      }
    };

    final resultOrFailure =
        await launchRepository.fetchListLaunchQuery(payload);

    resultOrFailure.fold((listData) {
      emit(state.copyWith(
        status: () => LaunchUpcomingListStatus.success,
        list: () => listData.list,
      ));
    }, (failure) {
      emit(state.copyWith(
        status: () => LaunchUpcomingListStatus.failure,
        errorMessage: () => mapFailureToMessage(failure),
      ));
    });
  }
}
