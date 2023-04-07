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
import 'package:space_x_demo/0_data/models/crew_model.dart';
import 'package:space_x_demo/0_data/models/launch_model.dart';
import 'package:space_x_demo/0_data/models/launchpad_model.dart';
import 'package:space_x_demo/0_data/models/rocket_model.dart';
import 'package:space_x_demo/0_data/repositories/launch_repository.dart';
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
      addons: [
        CustomThemeAddon<ThemeData>(
          setting: ThemeSetting<ThemeData>(
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
            activeTheme: WidgetbookTheme(
              name: 'Dark',
              data: getDarkTheme(),
            ),
          ),
        ),
        LocalizationAddon(
          setting: LocalizationSetting(
            locales: locales,
            activeLocale: locales.first,
            localizationsDelegates: delegates,
          ),
        ),
        FrameAddon(
          setting: FrameSetting(
            frames: [
              NoFrame(),
              DefaultDeviceFrame(
                setting: DeviceSetting(
                  devices: [
                    Device(
                      name: 'Device',
                      resolution: Resolution(
                        nativeSize: DeviceSize(
                          height: 1400.0,
                          width: 700.0,
                        ),
                        scaleFactor: 2.0,
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
                  activeDevice: Device(
                    name: 'Device',
                    resolution: Resolution(
                      nativeSize: DeviceSize(
                        height: 1400.0,
                        width: 700.0,
                      ),
                      scaleFactor: 2.0,
                    ),
                    type: DeviceType.mobile,
                  ),
                ),
              ),
              WidgetbookFrame(
                setting: DeviceSetting(
                  devices: [
                    Device(
                      name: 'Device',
                      resolution: Resolution(
                        nativeSize: DeviceSize(
                          height: 1400.0,
                          width: 700.0,
                        ),
                        scaleFactor: 2.0,
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
                  activeDevice: Device(
                    name: 'Device',
                    resolution: Resolution(
                      nativeSize: DeviceSize(
                        height: 1400.0,
                        width: 700.0,
                      ),
                      scaleFactor: 2.0,
                    ),
                    type: DeviceType.mobile,
                  ),
                ),
              ),
            ],
            activeFrame: NoFrame(),
          ),
        ),
      ],
      directories: [
        WidgetbookFolder(
          name: '2_application',
          children: [
            WidgetbookFolder(
              name: 'core',
              children: [
                WidgetbookFolder(
                  name: 'widgets',
                  children: [
                    WidgetbookComponent(
                      name: 'MainAppBar',
                      useCases: [
                        WidgetbookUseCase(
                          name: 'Default',
                          builder: (context) => mainAppBarUseCase(context),
                        ),
                      ],
                      isInitiallyExpanded: true,
                    ),
                    WidgetbookComponent(
                      name: 'CustomCard',
                      useCases: [
                        WidgetbookUseCase(
                          name: 'Default',
                          builder: (context) => customCardUseCase(context),
                        ),
                      ],
                      isInitiallyExpanded: true,
                    ),
                    WidgetbookComponent(
                      name: 'ErrorMessage',
                      useCases: [
                        WidgetbookUseCase(
                          name: 'Default',
                          builder: (context) => errorMessageUseCase(context),
                        ),
                        WidgetbookUseCase(
                          name: 'Long message',
                          builder: (context) =>
                              longErrorMessageUseCase(context),
                        ),
                      ],
                      isInitiallyExpanded: true,
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
                      isInitiallyExpanded: true,
                    ),
                  ],
                  isInitiallyExpanded: true,
                ),
              ],
              isInitiallyExpanded: true,
            ),
            WidgetbookFolder(
              name: 'pages',
              children: [
                WidgetbookFolder(
                  name: 'launch_list_page',
                  children: [
                    WidgetbookComponent(
                      name: 'LaunchListPage',
                      useCases: [
                        WidgetbookUseCase(
                          name: 'Default',
                          builder: (context) => launchListPageUseCase(context),
                        ),
                      ],
                      isInitiallyExpanded: true,
                    ),
                    WidgetbookFolder(
                      name: 'widgets',
                      children: [
                        WidgetbookComponent(
                          name: 'FilterSection',
                          useCases: [
                            WidgetbookUseCase(
                              name: 'Default',
                              builder: (context) =>
                                  filterSectionUseCase(context),
                            ),
                          ],
                          isInitiallyExpanded: true,
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
                          isInitiallyExpanded: true,
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
                          isInitiallyExpanded: true,
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
                          isInitiallyExpanded: true,
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
                          isInitiallyExpanded: true,
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
                          isInitiallyExpanded: true,
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
                          isInitiallyExpanded: true,
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
                          isInitiallyExpanded: true,
                        ),
                        WidgetbookComponent(
                          name: 'TopListItem',
                          useCases: [
                            WidgetbookUseCase(
                              name: 'Default',
                              builder: (context) => topListItemUseCase(context),
                            ),
                          ],
                          isInitiallyExpanded: true,
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
                          isInitiallyExpanded: true,
                        ),
                      ],
                      isInitiallyExpanded: true,
                    ),
                  ],
                  isInitiallyExpanded: true,
                ),
                WidgetbookFolder(
                  name: 'launch_detail_page',
                  children: [
                    WidgetbookComponent(
                      name: 'LaunchDetailPage',
                      useCases: [
                        WidgetbookUseCase(
                          name: 'Default',
                          builder: (context) =>
                              launchDetailPageUseCase(context),
                        ),
                      ],
                      isInitiallyExpanded: true,
                    ),
                    WidgetbookFolder(
                      name: 'widgets',
                      children: [
                        WidgetbookComponent(
                          name: 'SkeletonDetailPage',
                          useCases: [
                            WidgetbookUseCase(
                              name: 'Default',
                              builder: (context) =>
                                  skeletonDetailPageUseCase(context),
                            ),
                          ],
                          isInitiallyExpanded: true,
                        ),
                        WidgetbookComponent(
                          name: 'CrewsSection',
                          useCases: [
                            WidgetbookUseCase(
                              name: 'Default',
                              builder: (context) => crewSectionUseCase(context),
                            ),
                          ],
                          isInitiallyExpanded: true,
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
                          isInitiallyExpanded: true,
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
                          isInitiallyExpanded: true,
                        ),
                      ],
                      isInitiallyExpanded: true,
                    ),
                  ],
                  isInitiallyExpanded: true,
                ),
              ],
              isInitiallyExpanded: true,
            ),
          ],
          isInitiallyExpanded: true,
        ),
      ],
      appBuilder: mainAppBuilder,
    );
  }
}
