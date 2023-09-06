import 'package:flutter/material.dart';
import 'package:new_tete/AppTheme/storage.dart';

class ThemeManager extends ChangeNotifier {
  MaterialColor _primaryColor = Colors.green;
  ThemeMode _themeMode = ThemeMode.system;

  get primaryColor => _primaryColor;
  get themeMode => _themeMode;

  saveTheme() async {
    await ThemeStorage.setTheme(_themeMode, _primaryColor);
  }

  updateColor(MaterialColor newColor) {
    _primaryColor = newColor;
    saveTheme();
    notifyListeners();
  }

  updateTheme(ThemeMode newMode) {
    _themeMode = newMode;
    saveTheme();
    notifyListeners();
  }
}
