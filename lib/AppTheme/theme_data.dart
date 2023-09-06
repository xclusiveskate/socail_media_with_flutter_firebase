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

  static ThemeData darkTheme(MaterialColor color) {
    return ThemeData(
        brightness: Brightness.dark,
        primarySwatch: color,
        cardTheme: CardTheme(
            color: Colors.grey,
            elevation: 3,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20))),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(Size(50, 30)))),
        textTheme: TextTheme(
            displayLarge: TextStyle(
                fontSize: 26, color: Colors.white, fontWeight: FontWeight.bold),
            displayMedium: TextStyle(
                fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
            displaySmall: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold)));
  }
}
