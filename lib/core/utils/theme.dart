import 'package:flutter/material.dart';
import 'package:se7ety/core/constants/app_fonts.dart';
import 'package:se7ety/core/utils/app_colors.dart';
import 'package:se7ety/core/utils/text_styles.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    fontFamily: AppFonts.cairo,

    inputDecorationTheme: InputDecorationTheme(
      suffixIconConstraints: BoxConstraints(minHeight: 22, minWidth: 22),
      errorMaxLines: 4,
      prefixIconColor: AppColors.primaryColor,
      suffixIconColor: AppColors.primaryColor,
      contentPadding: EdgeInsets.all(16),
      hintStyle: TextStyles.getSmall(color: AppColors.grayColor),

      fillColor: AppColors.accentColor,
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(24),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(24),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(24),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(24),
      ),
    ),
    colorScheme: ColorScheme.light(onSurface: AppColors.darkColor),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    fontFamily: AppFonts.cairo,
    colorScheme: ColorScheme.dark(onSurface: AppColors.whiteColor),
    inputDecorationTheme: InputDecorationTheme(
      suffixIconConstraints: BoxConstraints(minHeight: 22, minWidth: 22),
      errorMaxLines: 4,
      prefixIconColor: AppColors.primaryColor,
      suffixIconColor: AppColors.primaryColor,
      contentPadding: EdgeInsets.all(16),
      hintStyle: TextStyles.getSmall(color: AppColors.grayColor),
      fillColor: AppColors.darkColor.withValues(alpha: 3),
      border: OutlineInputBorder(
        borderSide: BorderSide.none,

        borderRadius: BorderRadius.circular(24),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(24),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(24),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(24),
      ),
      errorStyle: TextStyles.getSmall(),
    ),
  );
}
