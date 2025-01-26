import 'package:e_commerce/shared_pref/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController {
  final key = 'isDarkModes';
  saveThemeDataInBox(bool isDark) {
    SharedPreferencesHelper.setBoolean(key, isDark);
  }

  Future<bool?> getThemeDataFromBox() async {
    return await SharedPreferencesHelper.getBoolean(key) ?? false;
  }

  Future<ThemeMode> get themDataGet async =>
      (await getThemeDataFromBox())! ? ThemeMode.dark : ThemeMode.light;
  void changeTheme() async {
    Get.changeThemeMode(
        (await getThemeDataFromBox())! ? ThemeMode.light : ThemeMode.dark);
    saveThemeDataInBox(!(await getThemeDataFromBox())!);
  }
}
