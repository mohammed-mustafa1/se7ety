import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static late SharedPreferences prefs;
  static const String kToken = 'kToken';
  static const String kUserInfo = 'kUserInfo';
  static const String kThemeMode = 'kThemeMode';
  static Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static Future<void> setString(String key, String value) async {
    await prefs.setString(key, value);
  }

  static String getString(String key) => prefs.getString(key) ?? '';

  static setTheme({required ThemeMode themeMode}) {
    setString(kThemeMode, themeMode.name);
  }

  static ThemeMode get getTheme {
    final themeName = getString(kThemeMode);
    switch (themeName) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      case 'system':
        return ThemeMode.system;
      default:
        return ThemeMode.light;
    }
  }
}
