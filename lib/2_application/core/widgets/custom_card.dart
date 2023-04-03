import 'package:flutter/material.dart';
import 'package:space_x_demo/constants/constants.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as anno;
import 'package:widgetbook/widgetbook.dart';

@anno.WidgetbookUseCase(name: 'Default', type: CustomCard)
Widget customCardUseCase(BuildContext context) {
  return CustomCard(
    width: context.knobs.slider(
      label: 'Width',
      max: 1000,
      min: 150,
      initialValue: 200,
    ),
    height: context.knobs.slider(
      label: 'Height',
      max: 1000,
      min: 150,
      initialValue: 200,
    ),
    child: Column(
      children: [
        Expanded(
          child: Image.asset(
            'assets/images/placeholder.jpeg',
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        Text(
          context.knobs.text(
            label: 'Message Label',
            initialValue: 'Some Message',
          ),
        ),
      ],
    ),
  );
}

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
