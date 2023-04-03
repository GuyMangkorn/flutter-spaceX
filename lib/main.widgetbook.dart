// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// WidgetbookGenerator
// **************************************************************************

import 'dart:async';
import 'dart:core';
import 'package:animate_do/animate_do.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart';
import 'package:lottie/lottie.dart';
import 'package:skeletons/skeletons.dart';
import 'package:space_x_demo/0_data/datasources/launch_remote_datasource.dart';
import 'package:space_x_demo/0_data/repositories/launch_repo_impl.dart';
import 'package:space_x_demo/1_domain/entities/crew_entity.dart';
import 'package:space_x_demo/1_domain/entities/laucnhpad_entity.dart';
import 'package:space_x_demo/1_domain/entities/launch_entity.dart';
import 'package:space_x_demo/1_domain/entities/rocket_entity.dart';
import 'package:space_x_demo/1_domain/repositories/launch_repo.dart';
import 'package:space_x_demo/2_application/core/widgets/custom_card.dart';
import 'package:space_x_demo/2_application/core/widgets/error_message.dart';
import 'package:space_x_demo/2_application/core/widgets/fade_load_image.dart';
import 'package:space_x_demo/2_application/core/widgets/main_app_bar.dart';
import 'package:space_x_demo/2_application/pages/launch_detail_page/bloc/launch_detail_bloc.dart';
import 'package:space_x_demo/2_application/pages/launch_detail_page/launch_detail_page.dart';
import 'package:space_x_demo/2_application/pages/launch_detail_page/widgets/crews_section.dart';
import 'package:space_x_demo/2_application/pages/launch_detail_page/widgets/launchpad_section.dart';
import 'package:space_x_demo/2_application/pages/launch_detail_page/widgets/rocket_section.dart';
import 'package:space_x_demo/2_application/pages/launch_detail_page/widgets/skeleton_detail_page.dart';
import 'package:space_x_demo/2_application/pages/launch_detail_page/widgets/sliver_parent_header.dart';
import 'package:space_x_demo/2_application/pages/launch_list_page/bloc/launch_list_bloc.dart';
import 'package:space_x_demo/2_application/pages/launch_list_page/bloc/launch_upcoming_list_bloc.dart';
import 'package:space_x_demo/2_application/pages/launch_list_page/launch_list_page.dart';
import 'package:space_x_demo/2_application/pages/launch_list_page/widgets/bottom_list_section.dart';
import 'package:space_x_demo/2_application/pages/launch_list_page/widgets/bottom_list_tile.dart';
import 'package:space_x_demo/2_application/pages/launch_list_page/widgets/bottom_sheet_filter.dart';
import 'package:space_x_demo/2_application/pages/launch_list_page/widgets/circular_load_more.dart';
import 'package:space_x_demo/2_application/pages/launch_list_page/widgets/filter_section.dart';
import 'package:space_x_demo/2_application/pages/launch_list_page/widgets/skeleton_bottom_list.dart';
import 'package:space_x_demo/2_application/pages/launch_list_page/widgets/skeleton_top_list.dart';
import 'package:space_x_demo/2_application/pages/launch_list_page/widgets/top_header_section.dart';
import 'package:space_x_demo/2_application/pages/launch_list_page/widgets/top_list_section.dart';
import 'package:space_x_demo/2_application/pages/launch_list_page/widgets/top_list_tile.dart';
import 'package:space_x_demo/2_application/routes/argument_model/launch_detail_argument.dart';
import 'package:space_x_demo/constants/constants.dart';
import 'package:space_x_demo/constants/mock_constants.dart';
import 'package:space_x_demo/generated/l10n.dart';
import 'package:space_x_demo/injection.dart';
import 'package:space_x_demo/theme.dart';
import 'package:space_x_demo/utils/setup_widgetbook.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:widgetbook/widgetbook.dart';

void main() {
  runApp(HotReload());
}

class HotReload extends StatelessWidget {
  const HotReload({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      appInfo: AppInfo(
        name: 'Demo SpaceX Application',
      ),
      supportedLocales: locales,
      localizationsDelegates: delegates,
      themes: [
        WidgetbookTheme(
          name: 'Dark',
          data: getDarkTheme(),
        ),
        WidgetbookTheme(
          name: 'Light',
          data: getLightTheme(),
        ),
      ],
      devices: [
        Device(
          name: 'iPhone 12',
          resolution: Resolution(
            nativeSize: DeviceSize(
              height: 2532.0,
              width: 1170.0,
            ),
            scaleFactor: 3.0,
          ),
          type: DeviceType.mobile,
        ),
        Device(
          name: 'iPhone 13 Pro Max',
          resolution: Resolution(
            nativeSize: DeviceSize(
              height: 2778.0,
              width: 1284.0,
            ),
            scaleFactor: 3.0,
          ),
          type: DeviceType.mobile,
        ),
      ],
      categories: [
        WidgetbookCategory(
          name: 'use cases',
          folders: [
            WidgetbookFolder(
              name: '2_application',
              widgets: [],
              folders: [
                WidgetbookFolder(
                  name: 'core',
                  widgets: [],
                  folders: [
                    WidgetbookFolder(
                      name: 'widgets',
                      widgets: [
                        WidgetbookComponent(
                          name: 'MainAppBar',
                          useCases: [
                            WidgetbookUseCase(
                              name: 'Default',
                              builder: (context) => mainAppBarUseCase(context),
                            ),
                          ],
                          isExpanded: true,
                        ),
                        WidgetbookComponent(
                          name: 'CustomCard',
                          useCases: [
                            WidgetbookUseCase(
                              name: 'Default',
                              builder: (context) => customCardUseCase(context),
                            ),
                          ],
                          isExpanded: true,
                        ),
                        WidgetbookComponent(
                          name: 'ErrorMessage',
                          useCases: [
                            WidgetbookUseCase(
                              name: 'Default',
                              builder: (context) =>
                                  errorMessageUseCase(context),
                            ),
                            WidgetbookUseCase(
                              name: 'Long message',
                              builder: (context) =>
                                  longErrorMessageUseCase(context),
                            ),
                          ],
                          isExpanded: true,
                        ),
                        WidgetbookComponent(
                          name: 'FadeLoadImage',
                          useCases: [
                            WidgetbookUseCase(
                              name: 'Default',
                              builder: (context) =>
                                  fadeLoadImagePlaceholderUseCase(context),
                            ),
                          ],
                          isExpanded: true,
                        ),
                      ],
                      folders: [],
                      isExpanded: true,
                    ),
                  ],
                  isExpanded: true,
                ),
                WidgetbookFolder(
                  name: 'pages',
                  widgets: [],
                  folders: [
                    WidgetbookFolder(
                      name: 'launch_list_page',
                      widgets: [
                        WidgetbookComponent(
                          name: 'LaunchListPage',
                          useCases: [
                            WidgetbookUseCase(
                              name: 'Default',
                              builder: (context) =>
                                  launchListPageUseCase(context),
                            ),
                          ],
                          isExpanded: true,
                        ),
                      ],
                      folders: [
                        WidgetbookFolder(
                          name: 'widgets',
                          widgets: [
                            WidgetbookComponent(
                              name: 'FilterSection',
                              useCases: [
                                WidgetbookUseCase(
                                  name: 'Default',
                                  builder: (context) =>
                                      filterSectionUseCase(context),
                                ),
                              ],
                              isExpanded: true,
                            ),
                            WidgetbookComponent(
                              name: 'SkeletonTopList',
                              useCases: [
                                WidgetbookUseCase(
                                  name: 'Default',
                                  builder: (context) =>
                                      skeletonTopListListUseCase(context),
                                ),
                              ],
                              isExpanded: true,
                            ),
                            WidgetbookComponent(
                              name: 'SkeletonBottomList',
                              useCases: [
                                WidgetbookUseCase(
                                  name: 'Default',
                                  builder: (context) =>
                                      skeletonBottomListUseCase(context),
                                ),
                              ],
                              isExpanded: true,
                            ),
                            WidgetbookComponent(
                              name: 'TopListSection',
                              useCases: [
                                WidgetbookUseCase(
                                  name: 'Default',
                                  builder: (context) =>
                                      topListSectionUseCase(context),
                                ),
                              ],
                              isExpanded: true,
                            ),
                            WidgetbookComponent(
                              name: 'CircularLoadMore',
                              useCases: [
                                WidgetbookUseCase(
                                  name: 'Default',
                                  builder: (context) =>
                                      circularLoadMoreUseCase(context),
                                ),
                              ],
                              isExpanded: true,
                            ),
                            WidgetbookComponent(
                              name: 'TopHeaderSection',
                              useCases: [
                                WidgetbookUseCase(
                                  name: 'Default',
                                  builder: (context) =>
                                      topHeaderSectionUseCase(context),
                                ),
                              ],
                              isExpanded: true,
                            ),
                            WidgetbookComponent(
                              name: 'BottomListSection',
                              useCases: [
                                WidgetbookUseCase(
                                  name: 'Default',
                                  builder: (context) =>
                                      bottomListSectionUseCase(context),
                                ),
                              ],
                              isExpanded: true,
                            ),
                            WidgetbookComponent(
                              name: 'BottomListTile',
                              useCases: [
                                WidgetbookUseCase(
                                  name: 'Default',
                                  builder: (context) =>
                                      bottomListTileUseCase(context),
                                ),
                              ],
                              isExpanded: true,
                            ),
                            WidgetbookComponent(
                              name: 'TopListItem',
                              useCases: [
                                WidgetbookUseCase(
                                  name: 'Default',
                                  builder: (context) =>
                                      topListItemUseCase(context),
                                ),
                              ],
                              isExpanded: true,
                            ),
                            WidgetbookComponent(
                              name: 'BottomSheetFilter',
                              useCases: [
                                WidgetbookUseCase(
                                  name: 'Default',
                                  builder: (context) =>
                                      bottomSheetFilterUseCase(context),
                                ),
                              ],
                              isExpanded: true,
                            ),
                          ],
                          folders: [],
                          isExpanded: true,
                        ),
                      ],
                      isExpanded: true,
                    ),
                    WidgetbookFolder(
                      name: 'launch_detail_page',
                      widgets: [
                        WidgetbookComponent(
                          name: 'LaunchDetailPage',
                          useCases: [
                            WidgetbookUseCase(
                              name: 'Default',
                              builder: (context) =>
                                  launchDetailPageUseCase(context),
                            ),
                          ],
                          isExpanded: true,
                        ),
                      ],
                      folders: [
                        WidgetbookFolder(
                          name: 'widgets',
                          widgets: [
                            WidgetbookComponent(
                              name: 'SkeletonDetailPage',
                              useCases: [
                                WidgetbookUseCase(
                                  name: 'Default',
                                  builder: (context) =>
                                      skeletonDetailPageUseCase(context),
                                ),
                              ],
                              isExpanded: true,
                            ),
                            WidgetbookComponent(
                              name: 'CrewsSection',
                              useCases: [
                                WidgetbookUseCase(
                                  name: 'Default',
                                  builder: (context) =>
                                      crewSectionUseCase(context),
                                ),
                              ],
                              isExpanded: true,
                            ),
                            WidgetbookComponent(
                              name: 'LaunchpadSection',
                              useCases: [
                                WidgetbookUseCase(
                                  name: 'Default',
                                  builder: (context) =>
                                      launchpadSectionUseCase(context),
                                ),
                              ],
                              isExpanded: true,
                            ),
                            WidgetbookComponent(
                              name: 'RocketSection',
                              useCases: [
                                WidgetbookUseCase(
                                  name: 'Default',
                                  builder: (context) =>
                                      rocketSectionUseCase(context),
                                ),
                                WidgetbookUseCase(
                                  name: 'With image',
                                  builder: (context) =>
                                      rocketSectionWithImageUseCase(context),
                                ),
                              ],
                              isExpanded: true,
                            ),
                          ],
                          folders: [],
                          isExpanded: true,
                        ),
                      ],
                      isExpanded: true,
                    ),
                  ],
                  isExpanded: true,
                ),
              ],
              isExpanded: true,
            ),
          ],
          widgets: [],
        ),
      ],
      appBuilder: mainAppBuilder,
    );
  }
}
