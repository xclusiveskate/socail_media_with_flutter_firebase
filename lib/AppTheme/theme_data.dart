import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeDataState {
  static lightTheme(MaterialColor color, BuildContext context) {
    return ThemeData(
        brightness: Brightness.light,
        primarySwatch: color,
        useMaterial3: true,
        fontFamily: GoogleFonts.acme().fontFamily,
        textTheme: const TextTheme(
          displayLarge: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.normal),
          displayMedium: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.normal),
          displaySmall: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.normal),
        ),
        drawerTheme: DrawerThemeData(
            backgroundColor: Colors.tealAccent,
            shape:
                BeveledRectangleBorder(borderRadius: BorderRadius.circular(10)),
            width: MediaQuery.of(context).size.width / 2),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(),
        cardTheme: const CardTheme());
  }
}
