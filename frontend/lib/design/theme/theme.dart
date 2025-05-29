import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

//Theme data to be updated once Designs are ready
class CustomTheme {
  static ThemeData get theme {
    return ThemeData.light().copyWith(
      //Primary Theme Data
      primaryColor: const Color(0xFF388087),
      primaryColorLight: Colors.white,
      primaryColorDark: Colors.black,
      //App Bar theme
      appBarTheme: AppBarTheme(
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        foregroundColor: Colors.black,
        titleTextStyle: GoogleFonts.inter(
          fontSize: 20.sp,
          color: Colors.black,
          // App Bar Text style
        ),
      ),
      //Scaffold Theme Data
      scaffoldBackgroundColor: const Color(0xFFF5F5F5), //3
      textTheme: TextTheme(
        displayLarge: GoogleFonts.inter(
          fontSize: 24.sp,
          fontWeight: FontWeight.w700,
          color: const Color(0xff050B10),
        ),
        displayMedium: GoogleFonts.inter(
          fontSize: 24.sp,
          fontWeight: FontWeight.w500,
          color: const Color(0xff050B10),
        ),
        displaySmall: GoogleFonts.inter(
          fontSize: 24.sp,
          fontWeight: FontWeight.w400,
          color: const Color(0xff050B10),
        ),
        headlineLarge: GoogleFonts.inter(
          fontSize: 18.sp,
          color: const Color(0xff050B10),
          fontWeight: FontWeight.w700,
        ),
        headlineMedium: GoogleFonts.inter(
          fontSize: 18.sp,
          color: const Color(0xff050B10),
          fontWeight: FontWeight.w500,
        ),
        headlineSmall: GoogleFonts.inter(
          fontSize: 18.sp,
          color: const Color(0xff050B10),
          fontWeight: FontWeight.w400,
        ),
        titleLarge: GoogleFonts.inter(
          fontSize: 16.sp,
          color: const Color(0xff050B10),
          fontWeight: FontWeight.w700,
        ),
        titleMedium: GoogleFonts.inter(
          fontSize: 16.sp,
          color: const Color(0xff050B10),
          fontWeight: FontWeight.w500,
        ),
        titleSmall: GoogleFonts.inter(
          fontSize: 16.sp,
          color: const Color(0xff050B10),
          fontWeight: FontWeight.w400,
        ),
        labelLarge: GoogleFonts.inter(
          fontSize: 14.sp,
          color: const Color(0xff050B10),
          fontWeight: FontWeight.w700,
        ),
        labelMedium: GoogleFonts.inter(
          fontSize: 14.sp,
          color: const Color(0xff050B10),
          fontWeight: FontWeight.w500,
        ),
        labelSmall: GoogleFonts.inter(
          fontSize: 14.sp,
          color: const Color(0xff050B10),
          fontWeight: FontWeight.w300,
        ),
        bodyLarge: GoogleFonts.inter(
          fontSize: 12.sp,
          color: const Color(0xff050B10),
          fontWeight: FontWeight.w400,
        ),
        bodyMedium: GoogleFonts.inter(
          fontSize: 10.sp,
          color: const Color(0xff050B10),
          fontWeight: FontWeight.w300,
        ),
        bodySmall: GoogleFonts.inter(
          fontSize: 8.sp,
          color: const Color(0xff050B10),
          fontWeight: FontWeight.w300,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            const Color(0xff388087),
          ),
          foregroundColor: MaterialStateProperty.all<Color>(
            const Color(0xFFFFFFFF),
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0.r),
            ),
          ),
          textStyle: MaterialStateProperty.all<TextStyle>(
            GoogleFonts.inter(
              fontSize: 18.sp,
              color: const Color(0xFFFFFFFF),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: const Color(0xffFFFFFF),
        selectedLabelStyle: GoogleFonts.inter(
          fontSize: 8.sp,
          fontWeight: FontWeight.w700,
          color: const Color(0xFF388087),
        ),
        unselectedLabelStyle: GoogleFonts.inter(
          fontSize: 8.sp,
          fontWeight: FontWeight.w500,
          color: const Color(0xFF7E7E7E),
        ),
        selectedItemColor: const Color(0xFF388087),
        unselectedItemColor: const Color(0xFF7E7E7E),
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: true,
      ),
    );
  }
}
