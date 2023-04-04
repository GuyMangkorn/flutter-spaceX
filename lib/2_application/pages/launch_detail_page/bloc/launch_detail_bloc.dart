import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_x_demo/0_data/models/launch_detail_model.dart';
import 'package:space_x_demo/0_data/repositories/launch_repository.dart';
import 'package:space_x_demo/utils/failure/failures.dart';

part 'launch_detail_event.dart';
part 'launch_detail_state.dart';

class LaunchDetailBloc extends Bloc<LaunchDetailEvent, LaunchDetailState> {
  final LaunchRepository launchRepository;

  LaunchDetailBloc({required this.launchRepository})
      : super(const LaunchDetailState()) {
    on<LaunchDetailRequested>(_launchDetailRequestedHandler);
  }

  Future<void> _launchDetailRequestedHandler(
      LaunchDetailRequested event, Emitter<LaunchDetailState> emit) async {
    emit(state.copyWith(status: () => LaunchDetailStatus.loading));

    // full detail id : 5eb87d4dffd86e000604b38e
    final Map<String, dynamic> payload = {
      "query": {"_id": event.id},
      "options": {
        "populate": [
          {"path": "launchpad"},
          {"path": "crew"},
          {"path": "rocket"}
        ]
      }
    };

    final responseOrFailure =
        await launchRepository.fetchLaunchWithId(payload: payload);

    responseOrFailure.fold(
      (launchDetail) {
        emit(
          state.copyWith(
              status: () => LaunchDetailStatus.success,
              detail: () => [launchDetail]),
        );
      },
      (failure) {
        emit(
          state.copyWith(
            status: () => LaunchDetailStatus.failure,
            errorMessage: () => mapFailureToMessage(failure),
          ),
        );
      },
    );
  }
}
