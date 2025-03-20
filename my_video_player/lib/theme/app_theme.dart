import 'package:flutter/material.dart';

class AppTheme {
  // Define primary and accent colors
  static const Color primaryColor = Color(0xFF102027); // Deep teal blue
  static const Color secondaryColor = Color(0xFFFAAA1E); // Vibrant gold
  static const Color accentColor = Color(0xFF26A69A); // Aqua green
  static const Color cardColor = Color(0xFF1E2A30); // Darker blue-gray

  static final ThemeData themeData = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      // seedColor: primaryColor,
      primary: primaryColor,
      onPrimary: Colors.white,
      secondary: secondaryColor,
      onSecondary: Colors.black,
      surface: cardColor,
      onSurface: Colors.white,
      background: primaryColor,
      onBackground: Colors.white,
      error: Colors.redAccent,
      onError: Colors.white,
    ),

    // App Bar Styling
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
      elevation: 4,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: secondaryColor,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),

    // Icon Theme
    iconTheme: const IconThemeData(
      color: secondaryColor,
      size: 26,
    ),

    // Text Theme
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white, fontSize: 18),
      bodyMedium: TextStyle(color: Colors.white70, fontSize: 16),
      bodySmall: TextStyle(color: Colors.white60, fontSize: 14),
      headlineSmall: TextStyle(color: secondaryColor, fontSize: 24, fontWeight: FontWeight.bold),
      titleLarge: TextStyle(color: accentColor, fontSize: 20, fontWeight: FontWeight.w600),
    ),

    // Buttons
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: secondaryColor,
        foregroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 4,
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: accentColor,
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    ),

    // Text Fields
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: cardColor.withOpacity(0.8),
      hintStyle: TextStyle(color: Colors.white54),
      labelStyle: const TextStyle(color: Colors.white),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: secondaryColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: secondaryColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: accentColor, width: 2),
      ),
    ),

    // Dialogs
    dialogTheme: const DialogTheme(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(14))),
      backgroundColor: cardColor,
      titleTextStyle: TextStyle(color: secondaryColor, fontSize: 22, fontWeight: FontWeight.bold),
      contentTextStyle: TextStyle(color: Colors.white70, fontSize: 16),
    ),

    // Cards
    cardTheme: CardTheme(
      color: cardColor,
      shadowColor: secondaryColor.withOpacity(0.3),
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    ),

    // Floating Action Button
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: secondaryColor,
      foregroundColor: Colors.black,
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
  );
}
