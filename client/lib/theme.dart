import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

ThemeData light() => _from(
      ThemeData.from(colorScheme: const ColorScheme.light()),
    );

ThemeData dark() => _from(
      ThemeData.from(colorScheme: const ColorScheme.dark()),
    );

ThemeData _from(ThemeData theme) => theme.copyWith(
      appBarTheme: theme.appBarTheme.copyWith(
        elevation: 0,
        color: theme.colorScheme.background,
      ),
      accentColor: primaryOrSecondaryFrom(theme),
      cupertinoOverrideTheme: CupertinoThemeData(
        primaryColor: primaryOrSecondaryFrom(theme),
      ),
      cursorColor: primaryOrSecondaryFrom(theme),
      textSelectionColor: primaryOrSecondaryFrom(theme),
      textSelectionHandleColor: primaryOrSecondaryFrom(theme),
      primaryColor: primaryOrSecondaryFrom(theme),
      primaryTextTheme: theme.textTheme.apply(
        displayColor: theme.colorScheme.onBackground,
        bodyColor: theme.colorScheme.onBackground,
      ),
      buttonTheme: theme.buttonTheme.copyWith(
        buttonColor: primaryOrSecondaryFrom(theme),
      ),
      primaryIconTheme: theme.primaryIconTheme.copyWith(
        color: theme.colorScheme.onBackground,
      ),
    );

Color primaryOrSecondaryFrom(ThemeData theme) =>
    theme.brightness == Brightness.light
        ? theme.colorScheme.secondary
        : theme.colorScheme.primary;

Color onPrimaryOrOnSecondaryFrom(ThemeData theme) =>
    theme.brightness == Brightness.light
        ? theme.colorScheme.onSecondary
        : theme.colorScheme.onPrimary;
