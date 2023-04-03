import 'package:flutter/material.dart';
import 'package:space_x_demo/2_application/core/widgets/custom_card.dart';
import 'package:space_x_demo/2_application/core/widgets/fade_load_image.dart';
import 'package:space_x_demo/constants/constants.dart';
import 'package:space_x_demo/generated/l10n.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as anno;

@anno.WidgetbookUseCase(name: 'Default', type: BottomListTile)
Widget bottomListTileUseCase(BuildContext context) {
  final intl = S.of(context);
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      BottomListTile(
        id: 'id',
        name: context.knobs.text(label: 'Name', initialValue: 'name'),
        date: context.knobs.text(label: 'Date', initialValue: '12-02-2022'),
        onTap: () {},
        images: const [],
        intl: intl,
        isSuccess: context.knobs.boolean(label: 'Success', initialValue: true),
      ),
    ],
  );
}

class BottomListTile extends StatelessWidget {
  final String name;
  final String date;
  final String id;
  final Function() onTap;
  final List<String> images;
  final S intl;
  final bool isSuccess;
  const BottomListTile(
      {super.key,
      required this.id,
      required this.name,
      required this.date,
      required this.onTap,
      required this.images,
      required this.intl,
      required this.isSuccess});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Stack(
      children: [
        CustomCard(
          child: LayoutBuilder(builder: (context, constraints) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FadeLoadImage(
                  image: images.isNotEmpty ? images[0] : '',
                  height: Constants.horizontalImgHeight,
                  width: constraints.maxWidth * .4,
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: Constants.xs,
                      horizontal: Constants.sm,
                    ),
                    child: DefaultTextStyle(
                      style: textTheme.labelSmall!,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            name,
                            style: textTheme.labelMedium,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(date),
                          Text(intl.status_launched),
                          Text(
                              '${intl.launch_status} ${isSuccess ? intl.success : intl.failure}'),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(Constants.cardRadius),
              onTap: onTap,
            ),
          ),
        ),
      ],
    );
  }
}
