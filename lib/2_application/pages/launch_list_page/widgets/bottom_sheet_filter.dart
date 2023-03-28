import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_x_demo/2_application/pages/launch_list_page/bloc/launch_list_bloc.dart';
import 'package:space_x_demo/constants/constants.dart';
import 'package:space_x_demo/generated/l10n.dart';

const _defaultFilter = [false, false];

class BottomSheetFilter extends StatelessWidget {
  final LaunchListBloc bloc;
  const BottomSheetFilter({
    required this.bloc,
    super.key,
  });

  void _onFilterNameHandler(int index, BuildContext context) {
    context.read<LaunchListBloc>().add(
          LaunchListFilterRequested(
            filterByDate: false,
            filterByName: true,
            filterFlag: index == 0 ? 1 : -1,
          ),
        );
    Navigator.of(context).pop();
  }

  void _onFilterDateHandler(int index, BuildContext context) {
    context.read<LaunchListBloc>().add(
          LaunchListFilterRequested(
            filterByDate: true,
            filterByName: false,
            filterFlag: index == 0 ? -1 : 1,
          ),
        );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final S intl = S.of(context);
    return SizedBox(
      child: BlocProvider.value(
        value: bloc,
        child: Container(
          padding: const EdgeInsets.all(Constants.md),
          height: Constants.bottomSheetHeight,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(
                Constants.cardRadius,
              ),
            ),
          ),
          child: BlocBuilder<LaunchListBloc, LaunchListState>(
            builder: (context, state) {
              return Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.filter_alt),
                      const SizedBox(width: Constants.xs),
                      Text(
                        intl.filter,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(width: Constants.lg),
                    ],
                  ),
                  const SizedBox(height: Constants.sm),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        intl.by_name,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      ToggleButtons(
                        key: const Key('t1'),
                        onPressed: (index) =>
                            _onFilterNameHandler(index, context),
                        isSelected: state.filter.filterByName
                            ? [
                                state.filter.filterFlag == 1,
                                state.filter.filterFlag == -1,
                              ]
                            : _defaultFilter,
                        children: [
                          Text(intl.a_z),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: Constants.md,
                              vertical: Constants.xs,
                            ),
                            child: Text(intl.z_a),
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: Constants.md),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        intl.by_launch_date,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      ToggleButtons(
                        key: const Key('t2'),
                        onPressed: (index) =>
                            _onFilterDateHandler(index, context),
                        isSelected: state.filter.filterByDate
                            ? [
                                state.filter.filterFlag == -1,
                                state.filter.filterFlag == 1,
                              ]
                            : _defaultFilter,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: Constants.md,
                              vertical: Constants.xs,
                            ),
                            child: Text(intl.newer),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: Constants.md,
                              vertical: Constants.xs,
                            ),
                            child: Text(intl.older),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
