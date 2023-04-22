import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppController extends GetxController {
  final themeMode = ThemeMode.system.obs;

  void changeThemeMode(Brightness brightness) {
    ThemeMode newThemeMode;

    if (themeMode.value == ThemeMode.system) {
      if (brightness == Brightness.light) {
        newThemeMode = ThemeMode.dark;
      } else {
        newThemeMode = ThemeMode.light;
      }
    } else if (themeMode.value == ThemeMode.light) {
      newThemeMode = ThemeMode.dark;
    } else {
      newThemeMode = ThemeMode.system;
    }

    themeMode.value = newThemeMode;
  }

  void changeThemeModeToDark() {
    themeMode.value = ThemeMode.dark;
  }

  void changeThemeModeToLight() {
    themeMode.value = ThemeMode.light;
  }

  void changeThemeModeToSystem() {
    themeMode.value = ThemeMode.system;
  }
}
