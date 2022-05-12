import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies/app/core/theme/app_colors.dart';

class AppTheme {
  static var appTheme = ThemeData(
      colorScheme: const ColorScheme.light(
          secondary: Colors.white, brightness: Brightness.dark),
      textTheme: TextTheme(
        bodyText1: GoogleFonts.montserrat(
            color: AppColors.colorGray01,
            fontSize: 12.sp,
            fontWeight: FontWeight.w600),
        bodyText2: GoogleFonts.montserrat(
            color: AppColors.colorGray01,
            fontSize: 14.sp,
            fontWeight: FontWeight.w600),
        headline1: GoogleFonts.montserrat(
            color: AppColors.colorHighlight,
            fontSize: 34.sp,
            fontWeight: FontWeight.w600),
        headline2: GoogleFonts.montserrat(
            color: AppColors.colorGray01,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600),
      ),
      textSelectionTheme:
          const TextSelectionThemeData(cursorColor: AppColors.colorGray08),
      cardColor: AppColors.colorWhite,
      splashColor: AppColors.colorHighlight,
      scaffoldBackgroundColor: Colors.transparent,
      brightness: Brightness.dark,
      fontFamily: "Montserrat",
      appBarTheme: const AppBarTheme(
          color: Colors.transparent,
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarBrightness: Brightness.dark,
              statusBarIconBrightness: Brightness.dark)));
}
