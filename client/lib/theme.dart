import 'package:flutter/material.dart' hide ThemeData;
import 'package:flutter/material.dart' as material show ThemeData;

material.ThemeData light() => _light.copyWith(
      appBarTheme: _light.appBarTheme.copyWith(elevation: 0),
      canvasColor: Colors.white,
      scaffoldBackgroundColor: Colors.white,
      accentColor: Colors.black,
      primaryColor: Colors.white,
      primaryTextTheme: _light.primaryTextTheme.copyWith(
        title: _light.primaryTextTheme.title.copyWith(color: Colors.black),
      ),
      primaryIconTheme: _dark.iconTheme.copyWith(color: Colors.black),
      snackBarTheme: _light.snackBarTheme.copyWith(
        backgroundColor: Colors.black,
        actionTextColor: Colors.white,
      ),
    );

material.ThemeData dark() => _dark.copyWith(
      appBarTheme: _dark.appBarTheme.copyWith(elevation: 0),
      canvasColor: Colors.black,
      scaffoldBackgroundColor: Colors.black,
      accentColor: Colors.white,
      primaryColor: Colors.black,
      primaryTextTheme: _dark.primaryTextTheme.copyWith(
        title: _dark.primaryTextTheme.title.copyWith(color: Colors.white),
      ),
      primaryIconTheme: _dark.iconTheme.copyWith(color: Colors.white),
      snackBarTheme: _light.snackBarTheme.copyWith(
        backgroundColor: Colors.white,
        actionTextColor: Colors.black,
      ),
    );

final _light = material.ThemeData.light();
final _dark = material.ThemeData.dark();
