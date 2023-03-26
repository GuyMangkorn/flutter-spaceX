import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_x_demo/2_application/pages/launch_list_page/bloc/launch_list_bloc.dart';
import 'package:space_x_demo/constants/constants.dart';
import 'package:space_x_demo/generated/l10n.dart';

const _defaultFilter = [false, false];

class FilterSection extends StatefulWidget {
  const FilterSection({
    super.key,
    required this.intl,
  });

  final S intl;

  @override
  State<FilterSection> createState() => _FilterSectionState();
}

class _FilterSectionState extends State<FilterSection> {
  final TextEditingController _textController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    _textController.addListener(() {
      if (_debounce?.isActive ?? false) {
        _debounce!.cancel();
      }

      _debounce = Timer(
          const Duration(
            milliseconds: Constants.searchDelayMilliseconds,
          ), () {
        if (_textController.text.isNotEmpty) {
          context.read<LaunchListBloc>().add(
                LaunchListSearchByTextRequested(
                  textSearch: _textController.text,
                ),
              );
        } else {
          context.read<LaunchListBloc>().add(LaunchListRequested());
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _textController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Constants.sm,
        vertical: Constants.sm,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _textController,
                  cursorColor: Theme.of(context).hintColor,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    hintText: widget.intl.hint_text,
                  ),
                ),
              ),
              const SizedBox(width: Constants.xs),
              Material(
                color: Theme.of(context).primaryColorLight,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                shape: const CircleBorder(),
                child: IconButton(
                  onPressed: () {
                    _buildModalBottomSheet(
                      context,
                      BlocProvider.of<LaunchListBloc>(context),
                      widget.intl,
                    );
                  },
                  icon: const Icon(Icons.filter_alt),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

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

  Future<dynamic> _buildModalBottomSheet(
      BuildContext context, LaunchListBloc bloc, S intl) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return BlocProvider.value(
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
                          onPressed: (index) =>
                              _onFilterNameHandler(index, context),
                          isSelected: state.filter.filterByName
                              ? [
                                  state.filter.filterFlag == 1,
                                  state.filter.filterFlag == -1,
                                ]
                              : _defaultFilter,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: Constants.md,
                                vertical: Constants.xs,
                              ),
                              child: Text(intl.a_z),
                            ),
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
        );
      },
    );
  }
}
