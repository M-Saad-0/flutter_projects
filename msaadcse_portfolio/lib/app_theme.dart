import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemes {
  // Core Colors
  static const Color twitterBlue = Color(0xFF1DA1F2);
  static const Color twitterDarkBlue = Color(0xFF15202B);
  static const Color twitterDarkCard = Color(0xFF192734);
  static const Color twitterLightBG = Color(0xFFF5F8FA);
  static const Color twitterDarkBG = Color(0xFF0A0F1B);
  static const Color accentTeal = Color(0xFF26C6DA);
  static const Color accentGray = Color(0xFF657786);

  // Common properties
  static final cardShape = ContinuousRectangleBorder(borderRadius: BorderRadius.circular(20));
  static final cardMargin = EdgeInsets.symmetric(horizontal: 16, vertical: 8);

  // Light Theme
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: twitterLightBG,
    primaryColor: twitterBlue,

    appBarTheme: AppBarTheme(
      backgroundColor: twitterLightBG,
      elevation: 2,
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

    textTheme: GoogleFonts.interTextTheme(
      TextTheme(
        displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.w800, color: Colors.black87, letterSpacing: -0.5),
        headlineMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: Colors.black87),
        bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black87),
        bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black54),
        labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: twitterBlue),
      ),
    ),

    cardTheme: CardTheme(
      color: Colors.white,
      elevation: 3,
      shadowColor: Colors.black.withOpacity(0.15),
      shape: cardShape,
      margin: cardMargin,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: twitterBlue,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: cardShape,
        elevation: 2,
        textStyle: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        shape: WidgetStatePropertyAll<OutlinedBorder>(cardShape),
      ),
    ),

    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: accentTeal,
      foregroundColor: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),

    iconTheme: IconThemeData(color: Colors.black87, size: 24),

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

    dividerTheme: DividerThemeData(
      color: Colors.grey.shade300,
      thickness: 1,
      space: 16,
      indent: 16,
      endIndent: 16,
    ),

    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(color: Colors.black87, borderRadius: BorderRadius.circular(8)),
      textStyle: TextStyle(color: Colors.white),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey.shade100,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    ),

    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: twitterBlue,
      linearTrackColor: Colors.grey.shade300,
      circularTrackColor: Colors.grey.shade200,
      refreshBackgroundColor: Colors.white,
      linearMinHeight: 6,
      // circularRadius: Radius.circular(8),
    ),
  );

  // Dark Theme
  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: twitterDarkBG,
    primaryColor: twitterBlue,

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

    textTheme: GoogleFonts.interTextTheme(
      TextTheme(
        displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.w800, color: Colors.white, letterSpacing: -0.5),
        headlineMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: Colors.white),
        bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
        bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white70),
        labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: twitterBlue),
      ),
    ),

    cardTheme: CardTheme(
      color: twitterDarkCard,
      elevation: 3,
      shadowColor: Colors.black.withOpacity(0.2),
      shape: cardShape,
      margin: cardMargin,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: twitterBlue,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: cardShape,
        elevation: 2,
        textStyle: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        shape: WidgetStatePropertyAll<OutlinedBorder>(cardShape),
      ),
    ),

    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: accentTeal,
      foregroundColor: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),

    iconTheme: IconThemeData(color: Colors.white70, size: 24),

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

    dividerTheme: DividerThemeData(
      color: const Color.fromARGB(255, 10, 14, 65),
      thickness: 1,
      space: 16,
      indent: 16,
      endIndent: 16,
    ),

    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(8)),
      textStyle: TextStyle(color: Colors.white),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: twitterDarkCard,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    ),

    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: twitterBlue,
      circularTrackColor: twitterDarkCard,
      linearTrackColor: Colors.grey.shade700,
      linearMinHeight: 6,
      // borderRadius: Radius.circular(8),
    ),
  );
}
