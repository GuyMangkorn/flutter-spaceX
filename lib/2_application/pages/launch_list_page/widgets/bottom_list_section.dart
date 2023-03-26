import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_x_demo/1_domain/entities/launch_entity.dart';
import 'package:space_x_demo/2_application/pages/launch_list_page/bloc/launch_list_bloc.dart';
import 'package:space_x_demo/2_application/pages/launch_list_page/widgets/bottom_list_tile.dart';
import 'package:space_x_demo/constants/constants.dart';

class BottomListSection extends StatefulWidget {
  final List<LaunchEntity> listData;
  final LaunchListStatus status;

  const BottomListSection({
    required this.listData,
    required this.status,
    super.key,
  });

  @override
  State<BottomListSection> createState() => _BottomListSectionState();
}

class _BottomListSectionState extends State<BottomListSection> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      BlocProvider.of<LaunchListBloc>(context).add(LaunchListLoadMoreRequested());
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    return Expanded(
      child: ListView.separated(
        controller: _scrollController,
        padding: EdgeInsets.only(
          top: Constants.sm,
          left: Constants.md,
          right: Constants.md,
          bottom: bottomPadding + Constants.xs,
        ),
        itemBuilder: (context, index) {
          return BottomListTile(
            id: widget.listData[index].id,
            name: widget.listData[index].name,
            date: widget.listData[index].dateUtc,
            images: widget.listData[index].images,
            onTap: () {
              Navigator.of(context).pushNamed(
                '/detail',
                arguments: {
                  "id": widget.listData[index].id,
                  "name": widget.listData[index].name,
                  "image": widget.listData[index].images.isNotEmpty
                      ? widget.listData[index].images[0]
                      : ''
                },
              );
            },
          );
        },
        separatorBuilder: (context, index) =>
            const SizedBox(height: Constants.md),
        itemCount: widget.listData.length,
      ),
    );
  }
}
