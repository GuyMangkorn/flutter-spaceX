import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';
import 'package:space_x_demo/constants/constants.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as anno;

@anno.WidgetbookUseCase(name: 'Default', type: SkeletonTopList)
Widget skeletonTopListListUseCase(BuildContext context) {
  return const SkeletonTopList();
}

class SkeletonTopList extends StatelessWidget {
  const SkeletonTopList({super.key});

  @override
  Widget build(BuildContext context) {
    final phoneSize = MediaQuery.of(context).size;
    return SizedBox(
      height: Constants.cardHeight,
      child: ListView.separated(
        padding: const EdgeInsets.all(Constants.sm),
        separatorBuilder: (context, index) {
          return const SizedBox(width: Constants.lg);
        },
        itemBuilder: (context, index) {
          return SizedBox(
            height: Constants.cardHeight,
            width: phoneSize.width * .8,
            child: SkeletonAvatar(
              style: SkeletonAvatarStyle(
                borderRadius: BorderRadius.circular(Constants.cardRadius),
                width: double.infinity,
              ),
            ),
          );
        },
        itemCount: Constants.numberOfSkeleton,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
