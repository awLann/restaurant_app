import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemePrefsProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  ThemeMode get themeMode => _themeMode;

  Future<void> getThemePrefs() async {
    final pref = await SharedPreferences.getInstance();
    final isDarkMode = pref.getBool("isDarkMode") ?? false;
    _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  Future<void> setThemePrefs() async {
    final pref = await SharedPreferences.getInstance();
    if (_themeMode == ThemeMode.light) {
      _themeMode = ThemeMode.dark;
      await pref.setBool("isDarkMode", true);
    } else {
      _themeMode = ThemeMode.light;
      await pref.setBool("isDarkMode", false);
    }
    notifyListeners();
  }
}
