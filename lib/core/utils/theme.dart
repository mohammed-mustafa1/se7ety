import 'package:flutter/material.dart';
import 'package:se7ety/core/constants/app_fonts.dart';
import 'package:se7ety/core/utils/app_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    fontFamily: AppFonts.cairo,
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.accentColor),
        borderRadius: BorderRadius.circular(8),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.accentColor),
        borderRadius: BorderRadius.circular(8),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.accentColor),
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    colorScheme: ColorScheme.light(onSurface: AppColors.darkColor),
    appBarTheme: AppBarTheme(
      surfaceTintColor: Colors.transparent,
      iconTheme: IconThemeData(color: AppColors.whiteColor),
    ),
  );
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    fontFamily: AppFonts.cairo,
    colorScheme: ColorScheme.dark(onSurface: AppColors.whiteColor),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.accentColor),
        borderRadius: BorderRadius.circular(8),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.accentColor),
        borderRadius: BorderRadius.circular(8),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.accentColor),
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    appBarTheme: AppBarTheme(
      surfaceTintColor: Colors.transparent,
      iconTheme: IconThemeData(color: AppColors.whiteColor),
    ),
  );
}
