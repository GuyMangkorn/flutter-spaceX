import 'package:flutter/material.dart';
import 'package:space_x_demo/1_domain/entities/laucnhpad_entity.dart';
import 'package:space_x_demo/2_application/core/widgets/fade_load_image.dart';
import 'package:space_x_demo/constants/constants.dart';
import 'package:space_x_demo/constants/mock_constants.dart';
import 'package:space_x_demo/generated/l10n.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as anno;

@anno.WidgetbookUseCase(name: 'Default', type: LaunchpadSection)
Widget launchpadSectionUseCase(BuildContext context) {
  final intl = S.of(context);
  return LaunchpadSection(
    launchpad: MockConstants.createLaunchpadEntity(
        name: context.knobs.text(label: 'Name', initialValue: 'name'),
        fullName: context.knobs
            .text(label: 'Full name', initialValue: 'full_name by spaceX'),
        details: context.knobs.text(
            label: 'Description',
            initialValue:
                'Et eu aliquip pariatur qui sit elit labore aliqua.Ad occaecat sint cupidatat culpa adipisicing Lorem qui qui magna nulla ad.'),
        image: context.knobs.options(
          label: 'Image options',
          options: const [
            Option(
              label: 'Without image',
              value: [],
            ),
            Option(
              label: 'With image',
              value: [''],
            )
          ],
        )),
    intl: intl,
  );
}

class LaunchpadSection extends StatelessWidget {
  const LaunchpadSection(
      {super.key, required this.launchpad, required this.intl});

  final LaunchpadEntity launchpad;
  final S intl;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          intl.launchpad,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        Text(
          launchpad.name,
          style: Theme.of(context).textTheme.labelLarge,
        ),
        Text(
          launchpad.fullName,
          style: Theme.of(context).textTheme.labelMedium,
        ),
        if (launchpad.image.isNotEmpty)
          Column(
            children: [
              const SizedBox(height: Constants.sm),
              ClipRRect(
                borderRadius: BorderRadius.circular(
                  Constants.detailRocketImgRadius,
                ),
                child: FadeLoadImage(
                  image: launchpad.image[0],
                  height: Constants.launchpadImgHeight,
                  width: double.infinity,
                ),
              ),
              const SizedBox(height: Constants.sm),
            ],
          ),
        const SizedBox(height: Constants.xs),
        Text(
          launchpad.details,
          style: Theme.of(context).textTheme.labelSmall,
        )
      ],
    );
  }
}
