import 'dart:async';
import 'dart:io';

import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  GoogleFonts.config.allowRuntimeFetching = false;
  return GoldenToolkit.runWithConfiguration(
    () async {
      await loadAppFonts();
      await testMain();
    },
    config: GoldenToolkitConfiguration(
      // Currently, goldens are not generated/validated in CI for this repo. We have settled on the goldens for this package
      // being captured/validated by developers running on MacOSX. We may revisit this in the future if there is a reason to invest
      // in more sophistication
      skipGoldenAssertion: () => !Platform.isMacOS,
    ),
  );
  // final ThemeData themeData = AppTheme.darkTheme;
  // WidgetsFlutterBinding.ensureInitialized();
  // return AlchemistConfig.runWithConfig(
  //   config: AlchemistConfig(
  //     theme: AppTheme.darkTheme,
  //     forceUpdateGoldenFiles: true,
  //   ),
  //   run: testMain,
  // );
}
