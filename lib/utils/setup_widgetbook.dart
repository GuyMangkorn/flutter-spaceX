import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart';
import 'package:space_x_demo/0_data/datasources/launch_remote_datasource.dart';
import 'package:space_x_demo/0_data/repositories/launch_repository.dart';
import 'package:space_x_demo/2_application/pages/launch_detail_page/bloc/launch_detail_bloc.dart';
import 'package:space_x_demo/2_application/pages/launch_list_page/bloc/launch_list_bloc.dart';
import 'package:space_x_demo/2_application/pages/launch_list_page/bloc/launch_upcoming_list_bloc.dart';
import 'package:space_x_demo/generated/l10n.dart';
import 'package:space_x_demo/theme.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as anno;
import 'package:widgetbook/widgetbook.dart';

final LaunchRepository repo = LaunchRepositoryImpl(
    launchRemoteDataSource: LaunchRemoteDataSourceImpl(client: Client()));

@anno.WidgetbookLocales()
const locales = <Locale>[
  Locale('en'),
  Locale('th'),
];

@anno.WidgetbookLocalizationDelegates()
final delegates = <LocalizationsDelegate>[
  S.delegate,
  GlobalMaterialLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate,
];

@anno.WidgetbookTheme(name: 'Dark', isDefault: true)
ThemeData getDarkTheme() => AppTheme.darkTheme;

@anno.WidgetbookTheme(name: 'Light', isDefault: false)
ThemeData getLightTheme() => ThemeData.light();

@anno.WidgetbookAppBuilder()
Widget mainAppBuilder(BuildContext context, Widget child) {
  // * ใน version 3 stable จะสามารถเรียก device โดยใช้ context.device ได้เลย
  // * https://github.com/widgetbook/widgetbook/pull/450

  final size = Apple.iPhone12.resolution.logicalSize;
  final changedSize = Size(size.width, size.height);
  final scaleRatio = Apple.iPhone12.resolution.scaleFactor;
  return MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) =>
            LaunchListBloc(launchRepository: repo)..add(LaunchListRequested()),
      ),
      BlocProvider(
        create: (context) => LaunchUpcomingListBloc(launchRepository: repo)
          ..add(LaunchUpcomingListRequested()),
      ),
      BlocProvider(
        create: (context) => LaunchDetailBloc(launchRepository: repo)
          ..add(const LaunchDetailRequested(id: '5eb87d4dffd86e000604b38e')),
      ),
    ],
    child: ScreenUtilInit(
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            padding: const EdgeInsets.all(10),
            size: changedSize,
            devicePixelRatio: scaleRatio,
          ),
          child: child!,
        );
      },
      useInheritedMediaQuery: true,
      minTextAdapt: true,
      child: child,
    ),
  );
}

const widgetBookDeviceList = [
  Device.mobile(
    name: 'Device',
    resolution: Resolution(
      nativeSize: DeviceSize(width: 700, height: 1400),
      scaleFactor: 2,
    ),
  )
];
