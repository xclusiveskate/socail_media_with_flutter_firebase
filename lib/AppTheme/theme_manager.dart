import 'package:flutter/material.dart';

class ThemeManager extends ChangeNotifier {
  MaterialColor _primaryColor = Colors.green;
  ThemeMode _themeMode = ThemeMode.system;

  get primaryColor => _primaryColor;
  get themeMode => _themeMode;

  updateColor(MaterialColor newColor) {
    _primaryColor = newColor;
    notifyListeners();
  }

  updateTheme(ThemeMode newMode) {
    _themeMode = newMode;
    notifyListeners();
  }
}
