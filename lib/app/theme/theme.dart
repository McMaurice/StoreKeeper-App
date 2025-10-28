import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:storekepper_app/app/constants/color.dart';

class AppTheme {
  // LIGHT THEME USING CUSTOM COLORS
  static final lightTheme = ThemeData(
    brightness: Brightness.light,

    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.primaryColor,
      onPrimary: Colors.white,
      secondary: AppColors.secondaryAccent,
      onSecondary: Colors.white,
      error: Colors.redAccent,
      onError: Colors.white,
      surface: Colors.white,
      onSurface: AppColors.textColor,
    ),

    // Custom font
    fontFamily: GoogleFonts.exo2().fontFamily,

    // App bar styling
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primaryColor,
      foregroundColor: Colors.white,
      elevation: 2,
      titleTextStyle: TextStyle(
        color: AppColors.titleColor,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
      centerTitle: true,
      iconTheme: const IconThemeData(color: Colors.white),
    ),

    cardTheme: CardThemeData(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    ),

    // Icon style
    iconTheme: IconThemeData(color: AppColors.primaryAccent, size: 22),
  );
}
