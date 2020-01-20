import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

ThemeData light() =>
    _from(ThemeData.from(colorScheme: const ColorScheme.light()));

ThemeData dark() =>
    _from(ThemeData.from(colorScheme: const ColorScheme.dark()));

ThemeData _from(ThemeData theme) => theme.copyWith(
      appBarTheme: theme.appBarTheme.copyWith(
        elevation: 0,
        color: theme.colorScheme.background,
      ),
      accentColor: _primaryOrSecondaryFrom(theme),
      cupertinoOverrideTheme: CupertinoThemeData(
        primaryColor: _primaryOrSecondaryFrom(theme),
      ),
      cursorColor: _primaryOrSecondaryFrom(theme),
      primaryColor: theme.colorScheme.background,
      primaryTextTheme: theme.textTheme.apply(
        displayColor: theme.colorScheme.onBackground,
        bodyColor: theme.colorScheme.onBackground,
      ),
      primaryIconTheme: theme.primaryIconTheme.copyWith(
        color: theme.colorScheme.onBackground,
      ),
    );

Color _primaryOrSecondaryFrom(ThemeData theme) =>
    theme.brightness == Brightness.light
        ? theme.colorScheme.secondary
        : theme.colorScheme.primary;
