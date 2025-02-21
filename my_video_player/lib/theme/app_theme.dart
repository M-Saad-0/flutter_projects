import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData themeData = ThemeData(
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFF16404D),
      onPrimary: Colors.white,
      secondary: Color(0xFFDDA853),
      onSecondary: Colors.black,
      surface: Color(0xFF16404D),
      onSurface: Color(0xFFDDA853),
      
      error: Colors.red,
      onError: Colors.white,
    ),
    appBarTheme:const AppBarTheme(
      backgroundColor: Color.fromARGB(255, 16, 48, 58),
      foregroundColor: Color(0xFFDDA853),
    ),
    iconTheme: const IconThemeData(
      color: Color(0xFFDDA853),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Color(0xFFDDA853)),
      bodyMedium: TextStyle(color: Color(0xFFDDA853)),
      bodySmall: TextStyle(color: Color(0xFFDDA853)),
    ),
    elevatedButtonTheme:  ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF16404D),
        foregroundColor: const Color(0xFFDDA853),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: const Color(0xFFDDA853),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF16404D),
      hintStyle: TextStyle(color: const Color(0xFFDDA853).withOpacity(0.7)),
      labelStyle: const TextStyle(color: Color(0xFFDDA853)),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFFDDA853)),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFFDDA853)),
      ),
    ),
    dialogTheme: const DialogTheme(
      shape: BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
      backgroundColor: Color(0xFF16404D),
      titleTextStyle: TextStyle(color: Color(0xFFDDA853), fontSize: 20),
      contentTextStyle: TextStyle(color: Color(0xFFDDA853), fontSize: 16),
    ),
    cardTheme: CardTheme(
      color: const Color(0xFF16404D),
      shadowColor: const Color(0xFFDDA853).withOpacity(0.5),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0xFF16404D),
      foregroundColor: Color(0xFFDDA853),
    ),
  );
}
