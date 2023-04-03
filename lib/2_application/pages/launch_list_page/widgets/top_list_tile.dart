import 'package:flutter/material.dart';
import 'package:space_x_demo/2_application/core/widgets/custom_card.dart';
import 'package:space_x_demo/2_application/core/widgets/fade_load_image.dart';
import 'package:space_x_demo/constants/constants.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as anno;

@anno.WidgetbookUseCase(name: 'Default', type: TopListItem)
Widget topListItemUseCase(BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Center(
        child: TopListItem(
          id: 'id',
          name: context.knobs.text(label: 'Name', initialValue: 'name'),
          date: context.knobs.text(label: 'Date', initialValue: '12-02-2022'),
          onTap: () {},
          images: const [],
        ),
      ),
    ],
  );
}

class TopListItem extends StatelessWidget {
  final String name;
  final String date;
  final String id;
  final Function() onTap;
  final List<String> images;
  const TopListItem({
    required this.name,
    required this.id,
    required this.date,
    required this.onTap,
    required this.images,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final phoneSize = MediaQuery.of(context).size;
    return Stack(
      children: [
        CustomCard(
          width: phoneSize.width * .8,
          height: Constants.cardHeight,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Hero(
                      tag: 'image_$id',
                      child: FadeLoadImage(
                        image: images.isNotEmpty ? images[0] : '',
                        width: constraints.maxWidth,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: Constants.md),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            name,
                            style: Theme.of(context).textTheme.labelLarge,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Flexible(
                          child: Text(
                            date,
                            style: Theme.of(context).textTheme.labelSmall,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.right,
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: Constants.xs),
                ],
              );
            },
          ),
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
