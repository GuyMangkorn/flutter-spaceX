import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_x_demo/constants/constants.dart';

class AppTheme {
  AppTheme._();

  static final Color _darkPrimaryColor = Colors.blueGrey.shade900;
  static const Color _darkPrimaryVariantColor = Colors.black;
  static final Color _darkOnPrimaryColor = Colors.blueGrey.shade300;
  static const Color _darkTextColorPrimary = Colors.white;
  static const Color _darkTextColorHint = Colors.white54;
  static final Color _appBarColorDark = Colors.blueGrey.shade800;

  static const Color _darkAccentPrimary = Color(0x313866FF);
  static const Color _darkAccentSecondary = Color(0x50409AFF);
  static const Color _darkAccentLight = Color(0x954EC2FF);

  static const Color _iconColor = Colors.white;

  static const Color _accentColor = Color.fromRGBO(74, 217, 217, 1);

  static const Color _progressIndicatorColor = Colors.white54;

  static const Color _inputBorderColor = _darkAccentSecondary;

  static const Color _shadowColor = Colors.white24;

  static final TextStyle _darkThemeHeadingTextStyle = GoogleFonts.kanit(
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.italic,
    color: _darkTextColorPrimary,
  );

  static final TextStyle _darkLabelText = GoogleFonts.kanit(
    fontWeight: FontWeight.w400,
    color: _darkTextColorPrimary,
    fontSize: 20,
  );

  static final TextStyle _darkInputLabelText = GoogleFonts.kanit(
    fontWeight: FontWeight.w300,
    color: _darkTextColorHint,
    fontSize: 16,
  );

  static final TextStyle _darkInputHintText =
      _darkInputLabelText.copyWith(fontStyle: FontStyle.italic);

  static final TextStyle _darkLabelMedium = _darkLabelText.copyWith(
    fontSize: 12,
    shadows: const [
      Shadow(color: Colors.black, blurRadius: 8),
    ],
  );

  static final TextStyle _darkLabelSmall = _darkLabelText.copyWith(
    fontSize: 10,
    fontStyle: FontStyle.italic,
  );

  static final TextStyle _darkBodySmall = _darkLabelText.copyWith(
    fontSize: 10,
  );

  static final TextTheme _darkTextTheme = TextTheme(
    headlineLarge: _darkThemeHeadingTextStyle,
    headlineMedium: _darkThemeHeadingTextStyle,
    headlineSmall: _darkThemeHeadingTextStyle,
    titleLarge: _darkThemeHeadingTextStyle,
    labelLarge: _darkLabelText,
    labelMedium: _darkLabelMedium,
    labelSmall: _darkLabelSmall,
    bodySmall: _darkBodySmall,
  );

  static final InputDecorationTheme _inputDecorationTheme =
      InputDecorationTheme(
    labelStyle: _darkInputLabelText,
    hintStyle: _darkInputHintText,
    contentPadding: const EdgeInsets.symmetric(horizontal: Constants.sm),
    fillColor: _darkAccentPrimary,
    filled: true,
    prefixIconColor: _darkTextColorHint,
    outlineBorder: const BorderSide(color: _inputBorderColor),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(Constants.textInputRadius),
      borderSide: const BorderSide(color: _darkAccentLight),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(Constants.textInputRadius),
      borderSide: const BorderSide(color: _inputBorderColor),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(Constants.textInputRadius),
      borderSide: const BorderSide(color: _inputBorderColor),
    ),
  );

  static const ProgressIndicatorThemeData _progressIndicatorThemeData =
      ProgressIndicatorThemeData(color: _progressIndicatorColor);

  static final ThemeData darkTheme = ThemeData(
    indicatorColor: _darkAccentSecondary,
    scaffoldBackgroundColor: _darkPrimaryColor,
    cardColor: _darkAccentPrimary,
    appBarTheme: AppBarTheme(
      color: _appBarColorDark,
      iconTheme: const IconThemeData(color: _iconColor),
    ),
    primaryColorLight: _darkAccentPrimary,
    hintColor: _darkTextColorHint,
    shadowColor: _shadowColor,
    colorScheme: ColorScheme.dark(
      primary: _darkPrimaryColor,
      secondary: _accentColor,
      onPrimary: _darkOnPrimaryColor,
      primaryContainer: _darkPrimaryVariantColor,
    ),
    textTheme: _darkTextTheme,
    toggleButtonsTheme: ToggleButtonsThemeData(
      textStyle: _darkLabelMedium,
      borderRadius: BorderRadius.circular(Constants.cardRadius),
      selectedColor: _darkTextColorPrimary,
      selectedBorderColor: _darkAccentLight,
      borderColor: _darkAccentLight,
      fillColor: _darkAccentPrimary,
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Colors.transparent,
    ),
    dividerColor: _darkTextColorPrimary,
    progressIndicatorTheme: _progressIndicatorThemeData,
    inputDecorationTheme: _inputDecorationTheme,
  );
}
