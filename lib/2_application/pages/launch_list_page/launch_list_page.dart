import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_x_demo/2_application/core/widgets/error_message.dart';
import 'package:space_x_demo/2_application/core/widgets/main_app_bar.dart';
import 'package:space_x_demo/2_application/pages/launch_list_page/bloc/launch_list_bloc.dart';
import 'package:space_x_demo/2_application/pages/launch_list_page/bloc/launch_upcoming_list_bloc.dart';
import 'package:space_x_demo/2_application/pages/launch_list_page/widgets/bottom_list_section.dart';
import 'package:space_x_demo/2_application/pages/launch_list_page/widgets/circular_load_more.dart';
import 'package:space_x_demo/2_application/pages/launch_list_page/widgets/filter_section.dart';
import 'package:space_x_demo/2_application/pages/launch_list_page/widgets/skeleton_bottom_list.dart';
import 'package:space_x_demo/2_application/pages/launch_list_page/widgets/skeleton_top_list.dart';
import 'package:space_x_demo/2_application/pages/launch_list_page/widgets/top_header_section.dart';
import 'package:space_x_demo/2_application/pages/launch_list_page/widgets/top_list_section.dart';
import 'package:space_x_demo/constants/constants.dart';
import 'package:space_x_demo/generated/l10n.dart';
import 'package:space_x_demo/injection.dart';

class LaunchListWrapper extends StatelessWidget {
  const LaunchListWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<LaunchListBloc>()..add(LaunchListRequested()),
        ),
        BlocProvider(
          create: (context) =>
              sl<LaunchUpcomingListBloc>()..add(LaunchUpcomingListRequested()),
        ),
      ],
      child: const LaunchListPage(),
    );
  }
}

class LaunchListPage extends StatelessWidget {
  const LaunchListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final intl = S.of(context);
    return Scaffold(
      appBar: MainAppBar(
        title: intl.title,
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        return RefreshIndicator(
          color: Theme.of(context).indicatorColor,
          onRefresh: () async {
            context.read<LaunchListBloc>().add(LaunchListRequested());
            context
                .read<LaunchUpcomingListBloc>()
                .add(LaunchUpcomingListRequested());
            final response = await Future.wait([
              context.read<LaunchUpcomingListBloc>().stream.first,
              context.read<LaunchListBloc>().stream.first,
            ]);

            print(response.toString());
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: SizedBox(
              height: constraints.maxHeight,
              child: FadeIn(
                child: Column(
                  children: [
                    TopHeaderSection(title: intl.upcoming),
                    _buildTopListSection(),
                    FilterSection(hintText: intl.hint_text),
                    _buildBottomListSection(),
                    const SizedBox(height: Constants.sm),
                    _buildLoadingMoreCircular(loadMoreText: intl.loading_more),
                    const SizedBox(height: Constants.md),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  BlocBuilder<LaunchListBloc, LaunchListState> _buildLoadingMoreCircular(
      {required String loadMoreText}) {
    return BlocBuilder<LaunchListBloc, LaunchListState>(
      buildWhen: (previous, current) =>
          current.status == LaunchListStatus.refresh ||
          current.status == LaunchListStatus.success,
      builder: (context, state) {
        if (state.status == LaunchListStatus.refresh) {
          return CircularLoadMore(loadMoreText: loadMoreText);
        } else {
          return const SizedBox();
        }
      },
    );
  }

  BlocBuilder<LaunchListBloc, LaunchListState> _buildBottomListSection() {
    return BlocBuilder<LaunchListBloc, LaunchListState>(
      builder: (context, state) {
        if (state.status == LaunchListStatus.success ||
            state.status == LaunchListStatus.refresh) {
          return BottomListSection(listData: state.list);
        } else if (state.status == LaunchListStatus.failure) {
          return ErrorMessage(message: state.errorMessage);
        } else {
          return const SkeletonBottomList();
        }
      },
    );
  }

  BlocBuilder<LaunchUpcomingListBloc, LaunchUpcomingListState>
      _buildTopListSection() {
    return BlocBuilder<LaunchUpcomingListBloc, LaunchUpcomingListState>(
      builder: (context, state) {
        if (state.status == LaunchUpcomingListStatus.success) {
          return TopListSection(listData: state.list);
        } else if (state.status == LaunchUpcomingListStatus.failure) {
          return ErrorMessage(message: state.errorMessage);
        } else {
          return const SkeletonTopList();
        }
      },
    );
  }
}
