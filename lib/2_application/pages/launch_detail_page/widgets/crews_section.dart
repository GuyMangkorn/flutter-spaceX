import 'package:flutter/material.dart';
import 'package:space_x_demo/0_data/models/crew_model.dart';
import 'package:space_x_demo/2_application/core/widgets/fade_load_image.dart';
import 'package:space_x_demo/constants/constants.dart';
import 'package:space_x_demo/constants/mock_constants.dart';
import 'package:space_x_demo/generated/l10n.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as anno;

@anno.WidgetbookUseCase(name: 'Default', type: CrewsSection)
Widget crewSectionUseCase(BuildContext context) {
  final intl = S.of(context);
  return CrewsSection(
    crews: MockConstants.mockCrews,
    intl: intl,
  );
}

class CrewsSection extends StatelessWidget {
  const CrewsSection({
    super.key,
    required this.crews,
    required this.intl,
  });

  final List<CrewModel> crews;
  final S intl;

  @override
  Widget build(BuildContext context) {
    final widthImg = MediaQuery.of(context).size.width * 0.35;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          intl.crews,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: Constants.xs),
        SizedBox(
          height: Constants.detailCrewImgHeight,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: crews.length,
            separatorBuilder: (context, index) =>
                const SizedBox(width: Constants.md),
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(
                      Constants.detailRocketImgRadius,
                    ),
                    child: FadeLoadImage(
                      image: crews[index].image,
                      height: Constants.detailCrewImgHeight,
                      width: widthImg,
                    ),
                  ),
                  Positioned(
                    width: widthImg,
                    bottom: 0,
                    left: 0,
                    child: Text(
                      crews[index].name,
                      style: Theme.of(context).textTheme.labelMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              );
            },
          ),
        )
      ],
    );
  }
}
