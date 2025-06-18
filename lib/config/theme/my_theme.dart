import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies/core/colors_manager.dart';

abstract class MyTheme {
  static ThemeData dark = ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor: ColorsManager.black,
      titleTextStyle: TextStyle(color: ColorsManager.yellow,fontSize: 16),
      iconTheme: IconThemeData(color: ColorsManager.yellow)
    ),
    iconTheme: IconThemeData(color: ColorsManager.white),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: GoogleFonts.inter(
        color: ColorsManager.white,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      fillColor: ColorsManager.blackWithOp,
      filled: true,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
    ),
    scaffoldBackgroundColor: ColorsManager.black,
    primaryColor: ColorsManager.yellow,
    textTheme: TextTheme(
      titleSmall: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: ColorsManager.yellow,
      ),
      titleMedium: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: ColorsManager.black,
      ),
      labelSmall: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: ColorsManager.gray,
      ),
      titleLarge: GoogleFonts.inter(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: ColorsManager.white,
      ),
      bodyMedium: GoogleFonts.roboto(
        fontSize: 20,
        fontWeight: FontWeight.w400,
        color: ColorsManager.white,
      ),
    ),
  );
}
