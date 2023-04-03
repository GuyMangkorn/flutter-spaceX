import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_x_demo/2_application/pages/launch_list_page/bloc/launch_list_bloc.dart';
import 'package:space_x_demo/2_application/pages/launch_list_page/widgets/bottom_sheet_filter.dart';
import 'package:space_x_demo/constants/constants.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as anno;

@anno.WidgetbookUseCase(name: 'Default', type: FilterSection)
Widget filterSectionUseCase(BuildContext context) {
  return FilterSection(
    hintText: context.knobs.text(label: 'Hint text', initialValue: 'Search...'),
  );
}

class FilterSection extends StatefulWidget {
  const FilterSection({
    super.key,
    required this.hintText,
  });

  final String hintText;

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
    _textController.dispose();
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
                    hintText: widget.hintText,
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

  Future<dynamic> _buildModalBottomSheet(
      BuildContext context, LaunchListBloc bloc) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return BottomSheetFilter(bloc: bloc);
      },
    );
  }
}
