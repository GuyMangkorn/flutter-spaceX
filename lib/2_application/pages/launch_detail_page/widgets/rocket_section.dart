import 'package:flutter/material.dart';
import 'package:space_x_demo/1_domain/entities/rocket_entity.dart';
import 'package:space_x_demo/2_application/core/widgets/fade_load_image.dart';
import 'package:space_x_demo/constants/constants.dart';
import 'package:space_x_demo/generated/l10n.dart';

class RocketSection extends StatelessWidget {
  const RocketSection({
    super.key,
    required this.rocket,
    required this.intl
  });

  final RocketEntity rocket;
  final S intl;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          intl.rocket,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: Constants.xs),
        if (rocket.images.isNotEmpty)
          SizedBox(
            height: Constants.detailRocketImgHeight,
            child: ListView.separated(
              separatorBuilder: (context, index) =>
                  const SizedBox(width: Constants.md),
              scrollDirection: Axis.horizontal,
              itemCount: rocket.images.length,
              itemBuilder: (context, index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(
                    Constants.detailRocketImgRadius,
                  ),
                  child: FadeLoadImage(
                    image: rocket.images[index],
                    height: Constants.detailRocketImgHeight,
                  ),
                );
              },
            ),
          ),
        const SizedBox(height: Constants.sm),
        Text(
          '${rocket.name} by ${rocket.company}',
          style: Theme.of(context).textTheme.labelMedium,
        ),
        Text(
          rocket.description,
          style: Theme.of(context).textTheme.labelSmall,
        ),
      ],
    );
  }
}
