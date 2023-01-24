import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

const Color primaryClr = Colors.deepPurple;

class Themes {
  static final light = ThemeData(
    primarySwatch: Colors.deepPurple,
    brightness: Brightness.light,
  );

  static final dark = ThemeData(
    primarySwatch: Colors.deepPurple,
    brightness: Brightness.dark,
  );
}

TextStyle get infoHeadingStyle {
  return GoogleFonts.lato(
      textStyle: (TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Get.isDarkMode ? Colors.grey[400] : Colors.grey)));
}

TextStyle get subHeadingStyle {
  return GoogleFonts.lato(
      textStyle: (TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Get.isDarkMode ? Colors.grey[400] : Colors.grey)));
}

TextStyle get headingStyle {
  return GoogleFonts.lato(
      textStyle: (const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  )));
}

TextStyle get inputTitleStyle {
  return GoogleFonts.lato(
      textStyle: (TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Get.isDarkMode ? Colors.white : Colors.black)));
}

TextStyle get placeholderStyle {
  return GoogleFonts.lato(
      textStyle: (TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Get.isDarkMode ? Colors.grey[100] : Colors.grey[600])));
}
