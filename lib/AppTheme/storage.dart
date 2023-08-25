import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeStorage {
  static setTheme(ThemeMode mode, MaterialColor color) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setInt('themeModeKey', mode.index);
    await pref.setInt('colorKey', color.value);
  }

  static Future<Map<String, dynamic>> loadTheme() async {
    final pref = await SharedPreferences.getInstance();
    final theModeIndex = pref.getInt('themeModeKey') ?? 0;
    final primaryColorValue =
        pref.getInt('colorKey') ?? Colors.teal.value;

    final themeMode = ThemeMode.values[theModeIndex];
    final primaryColor = Color(primaryColorValue);

    return {'themeMode': themeMode, 'primaryColor': primaryColor};
  }
}
