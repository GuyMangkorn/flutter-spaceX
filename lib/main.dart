import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:space_x_demo/2_application/routes/app_router.dart';
import 'package:space_x_demo/generated/l10n.dart';
import 'package:space_x_demo/theme.dart';
import 'package:space_x_demo/injection.dart' as di;
import 'package:space_x_demo/utils/setup_widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

final router = AppRouter();

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

@WidgetbookApp.material(
  name: 'Demo SpaceX Application',
  devices: widgetBookDeviceList,
  frames: [WidgetbookFrame(name: 'Widgetbook', allowsDevices: true)],
  foldersExpanded: true,
  widgetsExpanded: true,
)
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.darkTheme,
      darkTheme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: const Locale('en'),
      supportedLocales: S.delegate.supportedLocales,
      initialRoute: '/home',
      onGenerateRoute: router.onGenerateRoute,
    );
  }
}
