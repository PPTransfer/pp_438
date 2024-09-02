import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../core/app_export.dart';

LightCodeColors get appTheme => ThemeHelper().themeColor();

ThemeData get theme => ThemeHelper().themeData();

/// Helper class for managing themes and colors.
// ignore_for_file: must_be_immutable
class ThemeHelper {
  // The current app theme
  var _appTheme = PrefUtils().getThemeData();

// A map of custom color themes supported by the app
  Map<String, LightCodeColors> _supportedCustomColor = {
    'lightCode': LightCodeColors()
  };

// A map of color schemes supported by the app
  Map<String, ColorScheme> _supportedColorScheme = {
    'lightCode': ColorSchemes.lightCodeColorScheme
  };

  /// Returns the lightCode colors for the current theme.
  LightCodeColors _getThemeColors() {
    return _supportedCustomColor[_appTheme] ?? LightCodeColors();
  }

  /// Returns the current theme data.
  ThemeData _getThemeData() {
    var colorScheme =
        _supportedColorScheme[_appTheme] ?? ColorSchemes.lightCodeColorScheme;
    return ThemeData(
      visualDensity: VisualDensity.standard,
      colorScheme: colorScheme,
      textTheme: TextThemes.textTheme(colorScheme),
      scaffoldBackgroundColor: Colors.transparent,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
          visualDensity: const VisualDensity(
            vertical: -4,
            horizontal: -4,
          ),
          padding: EdgeInsets.zero,
        ),
      ),
      radioTheme: RadioThemeData(
        fillColor: WidgetStateColor.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return colorScheme.onPrimary.withOpacity(1);
          }
          return Colors.transparent;
        }),
        visualDensity: const VisualDensity(
          vertical: -4,
          horizontal: -4,
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: appTheme.red300,
      ),
    );
  }

  /// Returns the lightCode colors for the current theme.
  LightCodeColors themeColor() => _getThemeColors();

  /// Returns the current theme data.
  ThemeData themeData() => _getThemeData();
}

/// Class containing the supported text theme styles.
class TextThemes {
  static TextTheme textTheme(ColorScheme colorScheme) => TextTheme(
        displayLarge: GoogleFonts.nunito(
          color: colorScheme.onPrimary.withOpacity(1),
          fontSize: 46.fSize,
          fontWeight: FontWeight.w700,
        ),
        displayMedium: GoogleFonts.nunito(
          color: appTheme.gray90001,
          fontSize: 30.fSize,
          fontWeight: FontWeight.w700,
        ),
        displaySmall: GoogleFonts.nunito(
          color: colorScheme.onPrimary.withOpacity(1),
          fontSize: 20.fSize,
          fontWeight: FontWeight.w700,
        ),
        bodyLarge: GoogleFonts.montserrat(
          color: colorScheme.onPrimary.withOpacity(1),
          fontSize: 16.fSize,
          fontWeight: FontWeight.w500,
        ),
        bodySmall:  GoogleFonts.montserrat(
          color: colorScheme.onPrimary.withOpacity(1),
          fontSize: 12.fSize,
          fontWeight: FontWeight.w600,
        ),
        headlineMedium:  GoogleFonts.josefinSans(
          color: appTheme.black900,
          fontSize: 26.fSize,
          fontWeight: FontWeight.w500,
        ),
      );
}

/// Class containing the supported color schemes.
class ColorSchemes {
  static final lightCodeColorScheme = ColorScheme.light(
    primary: Color(0XFF444444),
    primaryContainer: Color(0XFFEAEAEA),
    onPrimary: Color(0X7FFFFFFF),
  );
}

/// Class containing custom colors for a lightCode theme.
class LightCodeColors {
  // Black
  Color get black900 => Color(0XFF000000);

// Gray
  Color get gray600 => Color(0XFF727272);

  Color get gray700 => Color(0XFF5D5D5D);

  Color get gray900 => Color(0XFF1B1B1B);

  Color get gray90001 => Color(0XFF141414);

// Red
  Color get red300 => Color(0XFFC58447);
}
