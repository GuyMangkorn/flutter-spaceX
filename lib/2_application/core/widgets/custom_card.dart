import 'package:flutter/material.dart';

import 'package:space_x_demo/constants/constants.dart';

class CustomCard extends StatelessWidget {
  final Widget? child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  const CustomCard({
    super.key,
    this.padding,
    this.width,
    this.height,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      shape: BoxShape.rectangle,
      color: Theme.of(context).cardColor,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      borderRadius: BorderRadius.circular(Constants.cardRadius),
      elevation: 8,
      child: Container(
        padding: padding,
        width: width,
        height: height,
        child: child,
      ),
    );
  }
}
