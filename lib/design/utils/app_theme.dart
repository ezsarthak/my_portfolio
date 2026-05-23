import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static final ThemeData darkTheme = ThemeData(
    fontFamily: 'Preah',
    brightness: Brightness.dark,
    primaryColor: AppColors.purple,
    scaffoldBackgroundColor: AppColors.bgColor,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.navBarColor,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      unselectedItemColor: Colors.grey.shade600,
      selectedItemColor: Colors.white,
      backgroundColor: Colors.black,
      selectedLabelStyle:
          const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
      unselectedLabelStyle:
          const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
      bodyMedium: TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.normal,
      ),
    ),
  );
}
