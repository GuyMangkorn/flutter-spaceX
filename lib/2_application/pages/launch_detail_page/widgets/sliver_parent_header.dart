import 'package:flutter/material.dart';
import 'package:space_x_demo/constants/constants.dart';

class SliverParentHeader extends SliverPersistentHeaderDelegate {
  final Widget child;
  SliverParentHeader({required this.child});
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => Constants.detailImgHeight;

  @override
  double get minExtent => 0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
