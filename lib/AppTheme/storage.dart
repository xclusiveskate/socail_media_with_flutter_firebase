import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeStorage {
  static setTheme(ThemeMode mode, MaterialColor color) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setInt('themeModeKey', mode.index);
    await pref.setInt('colorKey', color.value);
  }

  static Future<({ThemeMode mode, MaterialColor color})> loadTheme() async {
    final pref = await SharedPreferences.getInstance();
    final theModeIndex = pref.getInt('themeModeKey') ?? 0;
    final primaryColorValue = pref.getInt('colorKey') ?? Colors.teal.value;

    final themeMode = ThemeMode.values[theModeIndex];
    final primaryColor = MaterialColor(primaryColorValue, <int, Color>{
      50: Color(primaryColorValue),
      100: Color(primaryColorValue),
      200: Color(primaryColorValue),
      300: Color(primaryColorValue),
      400: Color(primaryColorValue),
      500: Color(primaryColorValue),
      600: Color(primaryColorValue),
      700: Color(primaryColorValue),
      800: Color(primaryColorValue),
      900: Color(primaryColorValue),
    });

    return (mode: themeMode, color: primaryColor);
  }
}
