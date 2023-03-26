import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:space_x_demo/2_application/routes/app_router.dart';
import 'package:space_x_demo/generated/l10n.dart';
import 'package:space_x_demo/theme.dart';
import 'package:space_x_demo/injection.dart' as di;

final router = AppRouter();

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  // await dotenv.load(fileName: '.env');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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
