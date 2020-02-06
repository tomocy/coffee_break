import 'package:flutter/material.dart';

class Settings {
  Settings({this.themeMode = ThemeMode.system});

  ThemeMode themeMode;

  @override
  int get hashCode => themeMode.hashCode;

  @override
  bool operator ==(dynamic other) =>
      other is Settings && other.themeMode == themeMode;
}

const themes = <ThemeMode, String>{
  ThemeMode.system: 'System',
  ThemeMode.dark: 'Dark',
  ThemeMode.light: 'Light',
};
