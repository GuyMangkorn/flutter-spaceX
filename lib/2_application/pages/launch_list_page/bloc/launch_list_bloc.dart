import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:space_x_demo/1_domain/entities/filter_entity.dart';
import 'package:space_x_demo/1_domain/entities/launch_entity.dart';
import 'package:space_x_demo/1_domain/entities/pagination_data_entity.dart';
import 'package:space_x_demo/1_domain/failure/failures.dart';
import 'package:space_x_demo/1_domain/repositories/launch_repo.dart';

part 'launch_list_event.dart';
part 'launch_list_state.dart';

const int limitPerPage = 20;

class LaunchListBloc extends Bloc<LaunchListEvent, LaunchListState> {
  final LaunchRepository launchRepository;

  LaunchListBloc({required this.launchRepository})
      : super(const LaunchListState()) {
    on<LaunchListRequested>(_onLaunchListRequestedHandler);
    on<LaunchListLoadMoreRequested>(_onLaunchListMoreRequestedHandler);
    on<LaunchListFilterRequested>(_launchListFilterRequestedHandler);
    on<LaunchListSearchByTextRequested>(_launchListSearchByTextRequested);
  }

  Future<void> _onLaunchListRequestedHandler(
    LaunchListRequested event,
    Emitter<LaunchListState> emit,
  ) async {
    emit(state.copyWith(status: () => LaunchListStatus.loading));

    dynamic sort = {};

    if (state.filter.filterByDate) {
      sort = {"date_utc": state.filter.filterFlag};
    } else {
      sort = {"name": state.filter.filterFlag};
    }

    Map<String, dynamic> payload = {
      "query": {"upcoming": false},
      "options": {
        "limit": limitPerPage,
        "sort": sort,
      }
    };

    final resultOrFailure =
        await launchRepository.fetchListLaunchQuery(payload);

    resultOrFailure.fold((listData) {
      emit(state.copyWith(
          status: () => LaunchListStatus.success,
          list: () => listData.list,
          paginationData: () => listData.paginationData!));
    }, (failure) {
      emit(state.copyWith(
        status: () => LaunchListStatus.failure,
        errorMessage: () => mapFailureToMessage(failure),
      ));
    });
  }

  Future<void> _onLaunchListMoreRequestedHandler(
    LaunchListLoadMoreRequested event,
    Emitter<LaunchListState> emit,
  ) async {
    emit(state.copyWith(status: () => LaunchListStatus.refresh));
    dynamic sort = {};

    if (state.filter.filterByDate) {
      sort = {"date_utc": state.filter.filterFlag};
    } else {
      sort = {"name": state.filter.filterFlag};
    }

    final newPage = state.paginationData.hasNextPage
        ? state.paginationData.page + 1
        : state.paginationData.page;

    Map<String, dynamic> payload = {
      "query": {"upcoming": false},
      "options": {
        "limit": limitPerPage,
        "page": newPage,
        "sort": sort,
      }
    };

    final resultOrFailure =
        await launchRepository.fetchListLaunchQuery(payload);

    resultOrFailure.fold((listData) {
      // * concat new items to list
      emit(state.copyWith(
          status: () => LaunchListStatus.success,
          list: () => [...state.list, ...listData.list],
          paginationData: () => listData.paginationData!));
    }, (failure) {
      emit(state.copyWith(
        status: () => LaunchListStatus.failure,
        errorMessage: () => mapFailureToMessage(failure),
      ));
    });
  }

  Future<void> _launchListFilterRequestedHandler(
    LaunchListFilterRequested event,
    Emitter<LaunchListState> emit,
  ) async {
    emit(
      state.copyWith(
        filter: () => FilterEntity(
          filterByDate: event.filterByDate,
          filterByName: event.filterByName,
          filterFlag: event.filterFlag,
        ),
        status: () => LaunchListStatus.loading,
      ),
    );

    dynamic sort = {};

    if (state.filter.filterByDate) {
      sort = {"date_utc": state.filter.filterFlag};
    } else {
      sort = {"name": state.filter.filterFlag};
    }

    Map<String, dynamic> payload = {
      "query": {"upcoming": false},
      "options": {
        "limit": limitPerPage,
        "sort": sort,
      }
    };

    final resultOrFailure =
        await launchRepository.fetchListLaunchQuery(payload);

    resultOrFailure.fold((listData) {
      emit(state.copyWith(
          status: () => LaunchListStatus.success,
          list: () => listData.list,
          paginationData: () => listData.paginationData!));
    }, (failure) {
      emit(state.copyWith(
        status: () => LaunchListStatus.failure,
        errorMessage: () => mapFailureToMessage(failure),
      ));
    });
  }

  Future<void> _launchListSearchByTextRequested(
    LaunchListSearchByTextRequested event,
    Emitter<LaunchListState> emit,
  ) async {
    emit(state.copyWith(status: () => LaunchListStatus.loading));

    dynamic sort = {};

    if (state.filter.filterByDate) {
      sort = {"date_utc": state.filter.filterFlag};
    } else {
      sort = {"name": state.filter.filterFlag};
    }

    Map<String, dynamic> payload = {
      "query": {
        "name": {
          "\$regex": "^${event.textSearch}",
          "\$options": "i",
        },
        "upcoming": false,
      },
      "options": {
        "limit": limitPerPage,
        "sort": sort,
      }
    };

    final resultOrFailure =
        await launchRepository.fetchListLaunchQuery(payload);

    resultOrFailure.fold((listData) {
      emit(state.copyWith(
          status: () => LaunchListStatus.success,
          list: () => listData.list,
          paginationData: () => listData.paginationData!));
    }, (failure) {
      emit(state.copyWith(
        status: () => LaunchListStatus.failure,
        errorMessage: () => mapFailureToMessage(failure),
      ));
    });
  }
}
