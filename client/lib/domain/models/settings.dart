import 'package:flutter/material.dart';

class Settings {
  Settings({this.themeMode = ThemeMode.system});

  ThemeMode themeMode;
}

const themes = <ThemeMode, String>{
  ThemeMode.system: 'System',
  ThemeMode.dark: 'Dark',
  ThemeMode.light: 'Light',
};
