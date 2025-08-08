import 'package:flutter/material.dart';
import 'package:se7ety/features/auth/data/models/user_enum.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static late SharedPreferences prefs;
  static const String kUserID = 'kUserID';
  static const String kUserType = 'kUserType';
  static const String kThemeMode = 'kThemeMode';
  static const String kIsOnboardingView = 'kIsOnBoardingView';
  static const String kIsDataCompleted = 'kIsDataCompleted';
  static Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static Future<void> setString(String key, String value) async {
    await prefs.setString(key, value);
  }

  static String getString(String key) => prefs.getString(key) ?? '';

  static set isOnBoardingView(bool value) {
    prefs.setBool(kIsOnboardingView, value);
  }

  static bool get isOnBoardingView => prefs.getBool(kIsOnboardingView) ?? true;

  static saveUserId({required String userID}) {
    setString(kUserID, userID);
  }

  static saveUserType({required UserType userType}) {
    setString(kUserType, userType.name);
  }

  static String getUserType() => getString(kUserType);

  static String getUserID() => getString(kUserID);

  static Future<bool> isDataCompleted({bool? value}) async {
    if (value == null) {
      return prefs.getBool(kIsDataCompleted) ?? false;
    } else {
      return await prefs.setBool(kIsDataCompleted, value);
    }
  }

  static setTheme({required ThemeMode themeMode}) {
    setString(kThemeMode, themeMode.name);
  }

  static Future<void> clearAllData() async {
    await prefs.clear();
  }

  static remove(String key) {
    prefs.remove(key);
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
