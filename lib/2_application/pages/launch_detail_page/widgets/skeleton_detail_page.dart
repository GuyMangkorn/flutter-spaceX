import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';
import 'package:space_x_demo/constants/constants.dart';

class SkeletonDetailPage extends StatelessWidget {
  const SkeletonDetailPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: Constants.xs),
        SkeletonLine(
          style: SkeletonLineStyle(
            alignment: Alignment.center,
            height: Constants.paragraphSkeletonHeight,
            borderRadius: BorderRadius.circular(Constants.baseRadius),
          ),
        ),
        const SizedBox(height: Constants.md),
        SkeletonLine(
          style: SkeletonLineStyle(
            width: Constants.skeletonTextHeaderHeight,
            randomLength: false,
            borderRadius: BorderRadius.circular(Constants.baseRadius),
          ),
        ),
        const SizedBox(height: Constants.sm),
        SkeletonItem(
          child: SizedBox(
            height: Constants.detailRocketImgHeight,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, i) => SkeletonAvatar(
                style: SkeletonAvatarStyle(
                  height: Constants.detailRocketImgHeight,
                  width: Constants.skeletonRocketImgWidth,
                  borderRadius: BorderRadius.circular(
                    Constants.detailRocketImgRadius,
                  ),
                ),
              ),
              separatorBuilder: (_, i) => const SizedBox(
                width: Constants.md,
              ),
              itemCount: 3,
            ),
          ),
        ),
        const SizedBox(height: Constants.sm),
        SkeletonParagraph(
          style: const SkeletonParagraphStyle(
            spacing: Constants.paragraphSkeletonSpacing,
            lineStyle: SkeletonLineStyle(
              height: Constants.paragraphSkeletonHeight,
            ),
            lines: Constants.paragraphSkeletonLines,
          ),
        ),
        const SizedBox(height: Constants.sm),
        SkeletonLine(
          style: SkeletonLineStyle(
            width: Constants.skeletonTextHeaderHeight,
            randomLength: false,
            borderRadius: BorderRadius.circular(
              Constants.baseRadius,
            ),
          ),
        ),
        const SizedBox(height: Constants.sm),
        SkeletonAvatar(
          style: SkeletonAvatarStyle(
            height: Constants.launchpadImgHeight,
            width: double.infinity,
            borderRadius: BorderRadius.circular(
              Constants.detailRocketImgRadius,
            ),
          ),
        )
      ],
    );
  }
}
