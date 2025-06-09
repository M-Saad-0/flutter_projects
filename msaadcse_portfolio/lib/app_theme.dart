import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemes {
  // Core Colors
  static const Color twitterBlue = Color(0xFF1DA1F2); // Primary Twitter Blue
  static const Color twitterDarkBlue = Color(0xFF15202B); // Dark mode accent
  static const Color twitterDarkCard = Color(0xFF192734); // Dark mode card
  static const Color twitterLightBG = Color(0xFFF5F8FA); // Softer light background
  static const Color twitterDarkBG = Color(0xFF0A0F1B); // Richer dark background
  static const Color accentTeal = Color(0xFF26C6DA); // Complementary accent for buttons
  static const Color accentGray = Color(0xFF657786); // Neutral gray for secondary elements

  // Light Theme
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: twitterLightBG,
    primaryColor: twitterBlue,
    // AppBar Theme
    appBarTheme: AppBarTheme(
      backgroundColor: twitterLightBG,
      elevation: 2, // Subtle shadow for depth
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.black.withOpacity(0.1),
      iconTheme: IconThemeData(color: Colors.black87),
      titleTextStyle: GoogleFonts.inter(
        color: Colors.black87,
        fontSize: 20,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.2,
      ),
    ),
    // Typography
    textTheme: GoogleFonts.interTextTheme(
      TextTheme(
        displayLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w800,
          color: Colors.black87,
          letterSpacing: -0.5,
        ),
        headlineMedium: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: Colors.black87,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Colors.black54,
        ),
        labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: twitterBlue,
        ),
      ),
    ),
    // Card Theme
    cardTheme: CardTheme(
      color: Colors.white,
      elevation: 3,
      shadowColor: Colors.black.withOpacity(0.15),
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),
    // Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: twitterBlue,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 2,
        textStyle: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        shape: WidgetStatePropertyAll<OutlinedBorder>(ContinuousRectangleBorder(borderRadius: BorderRadius.circular(20)))
      )
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: accentTeal,
      foregroundColor: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    // Icon Theme
    iconTheme: IconThemeData(
      color: Colors.black87,
      size: 24,
    ),
    // Color Scheme
    colorScheme: ColorScheme.light(
      primary: twitterBlue,
      secondary: accentTeal,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      background: twitterLightBG,
      surface: Colors.white,
      onSurface: Colors.black87,
      error: Colors.redAccent,
      onError: Colors.white,
    ),
    // Divider
    dividerTheme: DividerThemeData(
      color: Colors.grey.shade300,
      thickness: 1,
      space: 16,
    ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
      borderRadius: BorderRadius.all(Radius.circular(8))
      ,
    )
  );

  // Dark Theme
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: twitterDarkBG,
    primaryColor: twitterBlue,
    // AppBar Theme
    appBarTheme: AppBarTheme(
      backgroundColor: twitterDarkBlue,
      elevation: 2,
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.black.withOpacity(0.3),
      iconTheme: IconThemeData(color: Colors.white70),
      titleTextStyle: GoogleFonts.inter(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.2,
      ),
    ),
    // Typography
    textTheme: GoogleFonts.interTextTheme(
      TextTheme(
        displayLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w800,
          color: Colors.white,
          letterSpacing: -0.5,
        ),
        headlineMedium: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Colors.white70,
        ),
        labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: twitterBlue,
        ),
      ),
    ),
    // Card Theme
    cardTheme: CardTheme(
      color: twitterDarkCard,
      elevation: 3,
      shadowColor: Colors.black.withOpacity(0.2),
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),
    // Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: twitterBlue,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 2,
        textStyle: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: accentTeal,
      foregroundColor: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    // Icon Theme
    iconTheme: IconThemeData(
      color: Colors.white70,
      size: 24,
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        shape: WidgetStatePropertyAll<OutlinedBorder>(ContinuousRectangleBorder(borderRadius: BorderRadius.circular(20)))
      )
    ),
    // Color Schemes
    colorScheme: ColorScheme.dark(
      primary: twitterBlue,
      secondary: accentTeal,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      background: twitterDarkBG,
      surface: twitterDarkCard,
      onSurface: Colors.white70,
      error: Colors.redAccent,
      onError: Colors.white,
    ),
    // Divider
    dividerTheme: DividerThemeData(
      color: Colors.grey.shade800,
      thickness: 1,
      space: 16,
    ),

    progressIndicatorTheme: ProgressIndicatorThemeData(
      borderRadius: BorderRadius.all(Radius.circular(8))
      ,
    )
  );
}