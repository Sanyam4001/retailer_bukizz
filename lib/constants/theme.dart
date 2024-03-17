import 'package:flutter/material.dart';

import 'colors.dart';

class AppTheme{
  static ThemeData instance = lightThemeData;
  static ThemeData lightThemeData = ThemeData(
    hintColor: Colors.black,
    scaffoldBackgroundColor:AppColors.bgColor,
    splashColor: Colors.transparent,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    ),
    colorScheme: const ColorScheme.light(
      primary: AppColors.primaryColor,
      background: Colors.white,
    ),
    useMaterial3: true,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
    ),
  );
}