import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,

    scaffoldBackgroundColor:
    AppColors.appBackground,

    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
    ),

    fontFamily: 'Roboto',

    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
    ),

    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        color: AppColors.textDark,
        fontSize: 16,
      ),
      bodyMedium: TextStyle(
        color: AppColors.textDark,
        fontSize: 14,
      ),
      bodySmall: TextStyle(
        color: AppColors.textGrey,
        fontSize: 12,
      ),
    ),

    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
  );
}