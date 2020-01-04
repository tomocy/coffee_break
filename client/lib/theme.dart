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
      primaryTextTheme: theme.textTheme.apply(
        displayColor: theme.colorScheme.onBackground,
        bodyColor: theme.colorScheme.onBackground,
      ),
      primaryIconTheme: theme.primaryIconTheme.copyWith(
        color: theme.colorScheme.onBackground,
      ),
    );
