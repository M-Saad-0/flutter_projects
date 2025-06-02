import 'package:flutter/material.dart';

class AppTheme {
  static Color primaryColor = Colors.redAccent;
  static Color surfaceBelowColor = const Color.fromARGB(255, 29, 25, 39); //For scaffold background
  static Color surfaceAboveColor = const Color.fromARGB(255, 39, 34, 53); //For appbar / dialogs etc
  final darkTheme = ThemeData(
    primaryColor: primaryColor,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: surfaceBelowColor,
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(),
      fillColor: surfaceAboveColor,
    ),
    appBarTheme: AppBarTheme(
      // backgroundColor: surfaceAboveColor

    ),
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: primaryColor,
      onPrimary: Colors.white,
      secondary: Colors.amberAccent,
      onSecondary: Colors.black,
      error: Colors.redAccent,
      onError: Colors.white,
      surfaceContainer: surfaceBelowColor,
      onSurfaceVariant: Colors.white70,
      surface: surfaceAboveColor,
      onSurface: Colors.white,
    ),
  );


  final lightTheme = ThemeData(
    primaryColor: primaryColor,
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(),
      fillColor: Colors.white,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
    ),
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: primaryColor,
      onPrimary: Colors.white,
      secondary: Colors.amberAccent,
      onSecondary: Colors.black,
      error: Colors.redAccent,
      onError: Colors.white,
      surfaceContainer: Colors.white,
      onSurfaceVariant: Colors.black54,
      surface: Colors.white,
      onSurface: Colors.black,
    ),
  );
}