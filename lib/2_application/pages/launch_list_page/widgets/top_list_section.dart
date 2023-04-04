import 'package:flutter/material.dart';
import 'package:space_x_demo/0_data/models/launch_model.dart';
import 'package:space_x_demo/2_application/pages/launch_list_page/widgets/top_list_tile.dart';
import 'package:space_x_demo/2_application/routes/argument_model/launch_detail_argument.dart';
import 'package:space_x_demo/constants/constants.dart';
import 'package:space_x_demo/constants/mock_constants.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as anno;

@anno.WidgetbookUseCase(name: 'Default', type: TopListSection)
Widget topListSectionUseCase(BuildContext context) {
  return Column(
    children: [
      TopListSection(
        listData: MockConstants.mockListLaunch,
      ),
    ],
  );
}
class TopListSection extends StatelessWidget {
  final List<LaunchModel> listData;

  const TopListSection({
    super.key,
    required this.listData,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Constants.cardHeight,
      child: ListView.separated(
        padding: const EdgeInsets.all(Constants.sm),
        separatorBuilder: (_, index) => const SizedBox(width: Constants.lg),
        itemCount: listData.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return TopListItem(
            onTap: () {
              Navigator.of(context).pushNamed(
                '/detail',
                arguments: LaunchDetailArgument(
                  id: listData[index].id,
                  name: listData[index].name,
                  image: listData[index].images.isNotEmpty
                      ? listData[index].images[0]
                      : '',
                ),
              );
            },
            id: listData[index].id,
            name: listData[index].name,
            date: listData[index].dateUtc,
            images: listData[index].images,
          );
        },
      ),
    );
  }
}
