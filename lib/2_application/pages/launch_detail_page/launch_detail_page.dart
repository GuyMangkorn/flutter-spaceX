import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_x_demo/2_application/core/widgets/error_message.dart';
import 'package:space_x_demo/2_application/core/widgets/fade_load_image.dart';
import 'package:space_x_demo/2_application/core/widgets/main_app_bar.dart';
import 'package:space_x_demo/2_application/pages/launch_detail_page/bloc/launch_detail_bloc.dart';
import 'package:space_x_demo/2_application/pages/launch_detail_page/widgets/crews_section.dart';
import 'package:space_x_demo/2_application/pages/launch_detail_page/widgets/launchpad_section.dart';
import 'package:space_x_demo/2_application/pages/launch_detail_page/widgets/rocket_section.dart';
import 'package:space_x_demo/2_application/pages/launch_detail_page/widgets/skeleton_detail_page.dart';
import 'package:space_x_demo/2_application/pages/launch_detail_page/widgets/sliver_parent_header.dart';
import 'package:space_x_demo/2_application/routes/argument_model/launch_detail_argument.dart';
import 'package:space_x_demo/constants/constants.dart';
import 'package:space_x_demo/generated/l10n.dart';
import 'package:space_x_demo/injection.dart';

class LaunchDetailPageWrapper extends StatelessWidget {
  final LaunchDetailArgument args;
  const LaunchDetailPageWrapper({
    required this.args,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          sl<LaunchDetailBloc>()..add(LaunchDetailRequested(id: args.id)),
      child: LaunchDetailPage(args: args),
    );
  }
}

class LaunchDetailPage extends StatelessWidget {
  final LaunchDetailArgument args;
  const LaunchDetailPage({
    required this.args,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final paddingBottom = MediaQuery.of(context).padding.bottom;
    return Scaffold(
      appBar: MainAppBar(title: args.name),
      body: Padding(
        padding: EdgeInsets.only(bottom: paddingBottom + Constants.sm),
        child: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              delegate: SliverParentHeader(
                child: Hero(
                  tag: 'image_${args.id}',
                  child: FadeLoadImage(
                    image: args.image,
                    height: Constants.detailImgHeight,
                    width: double.infinity,
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  const SizedBox(height: Constants.xs),
                  _buildDetailSection(args, context),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Padding _buildDetailSection(
      LaunchDetailArgument params, BuildContext context) {
    final intl = S.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Constants.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FittedBox(
            fit: BoxFit.fitWidth,
            child: FadeIn(
              child: Text(
                params.name,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ),
          BlocBuilder<LaunchDetailBloc, LaunchDetailState>(
            builder: (context, state) {
              if (state.status == LaunchDetailStatus.success) {
                final rocket = state.detail[0].rocket;
                final crews = state.detail[0].crew;
                final launchpad = state.detail[0].launchpad;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Divider(),
                    RocketSection(rocket: rocket, intl: intl),
                    const SizedBox(height: Constants.md),
                    LaunchpadSection(launchpad: launchpad, intl: intl),
                    const SizedBox(height: Constants.md),
                    if (crews.isNotEmpty)
                      CrewsSection(crews: crews, intl: intl),
                  ],
                );
              } else if (state.status == LaunchDetailStatus.failure) {
                return ErrorMessage(message: state.errorMessage);
              }
              return const SkeletonDetailPage();
            },
          )
        ],
      ),
    );
  }
}
