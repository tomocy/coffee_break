import 'package:flutter/material.dart';

class Settings extends ChangeNotifier {
  Settings({ThemeMode themeMode}) : _themeMode = themeMode;

  ThemeMode _themeMode;

  ThemeMode get themeMode => _themeMode;

  set themeMode(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
  }
}
