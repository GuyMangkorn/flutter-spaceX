import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:space_x_demo/generated/l10n.dart';
import 'package:space_x_demo/theme.dart';

Future<void> pumpDeviceBuilderWithThemeWrapper({
  required WidgetTester tester,
  required DeviceBuilder deviceBuilder,
}) async {
  await tester.pumpDeviceBuilder(
    deviceBuilder,
    wrapper: materialAppWrapper(
      localizations: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: AppTheme.darkTheme,
    ),
  );
}
