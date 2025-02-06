import 'package:flutter/material.dart';
import 'package:test_app/shared/utils/constants.dart';

ThemeData appTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
    useMaterial3: true,
    appBarTheme: const AppBarTheme(
      color: Colors.white,
      scrolledUnderElevation: 0,
    ),
    fontFamily: oxygen400,
    splashColor: Colors.transparent,
    scaffoldBackgroundColor: Colors.white);
