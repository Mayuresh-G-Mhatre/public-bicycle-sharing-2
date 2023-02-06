import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTheme {
  static ThemeData lightTheme() {
    return ThemeData(
      fontFamily: GoogleFonts.poppins(
        fontWeight: FontWeight.w700,
      ).fontFamily,
    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
      fontFamily: GoogleFonts.poppins(
        fontWeight: FontWeight.w700,
      ).fontFamily,
      brightness: Brightness.dark,
      appBarTheme: const AppBarTheme(
        color: Color.fromARGB(255, 42, 42, 42),
      ),
    );
  }
}
