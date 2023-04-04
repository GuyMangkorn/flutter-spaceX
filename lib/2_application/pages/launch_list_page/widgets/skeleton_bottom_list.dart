import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';
import 'package:space_x_demo/2_application/core/widgets/custom_card.dart';
import 'package:space_x_demo/constants/constants.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as anno;

@anno.WidgetbookUseCase(name: 'Default', type: SkeletonBottomList)
Widget skeletonBottomListUseCase(BuildContext context) {
  return Column(
    children: const [
      SkeletonBottomList(),
    ],
  );
}

class SkeletonBottomList extends StatelessWidget {
  const SkeletonBottomList({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    return Expanded(
      child: ListView.separated(
        padding: EdgeInsets.only(
          top: Constants.sm,
          left: Constants.md,
          right: Constants.md,
          bottom: bottomPadding + Constants.xs,
        ),
        itemBuilder: (context, index) {
          return LayoutBuilder(builder: (context, constraints) {
            return CustomCard(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SkeletonAvatar(
                    style: SkeletonAvatarStyle(
                      width: constraints.maxWidth * .4,
                      height: Constants.horizontalImgHeight,
                    ),
                  ),
                  Expanded(
                    child: SkeletonParagraph(
                      style: SkeletonParagraphStyle(
                        padding: const EdgeInsets.all(Constants.sm),
                        lines: Constants.paragraphSkeletonLines,
                        spacing: Constants.paragraphSkeletonSpacing,
                        lineStyle: SkeletonLineStyle(
                          randomLength: false,
                          height: Constants.paragraphSkeletonHeight,
                          borderRadius:
                              BorderRadius.circular(Constants.baseRadius),
                          maxLength: constraints.maxWidth * .5,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          });
        },
        separatorBuilder: (context, index) =>
            const SizedBox(height: Constants.md),
        itemCount: Constants.numberOfSkeleton,
      ),
    );
  }
}
