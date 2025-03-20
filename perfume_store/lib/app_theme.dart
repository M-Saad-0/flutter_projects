import 'package:flutter/material.dart';

final Color primaryColor = const Color(0xFFB89B72); // Elegant gold-brown
final Color accentColor = const Color(0xFF6D4C41); // Rich woody brown

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: primaryColor,
  scaffoldBackgroundColor: const Color.fromARGB(255, 241, 233, 228),

  colorScheme: ColorScheme.light(
    primary: primaryColor,
    onPrimary: Colors.white,
    secondary: accentColor,
    onSecondary: Colors.white,
    error: Colors.red,
    onError: Colors.white,
    surface: Colors.white,
    onSurface: Colors.black87,
    tertiary: const Color(0xFFEFE6DD), // Soft beige for a premium feel
  ),

  /// **Tooltip**
  tooltipTheme: TooltipThemeData(
    decoration: BoxDecoration(
      color: accentColor,
      borderRadius: BorderRadius.circular(8),
    ),
    textStyle: const TextStyle(color: Colors.white),
    padding: const EdgeInsets.all(8.0),
  ),

  /// **AppBar**
  appBarTheme: AppBarTheme(
    backgroundColor: primaryColor,
    foregroundColor: Colors.white,
    elevation: 2,
    centerTitle: true,
    titleTextStyle: const TextStyle(
        fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
  ),

  /// **Card**
  cardTheme: CardTheme(
    color: const Color.fromARGB(255, 245, 240, 235),
    elevation: 6,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  ),

  /// **TabBar**
  tabBarTheme: TabBarTheme(
    labelColor: primaryColor,
    unselectedLabelColor: Colors.black54,
    indicator: UnderlineTabIndicator(
      borderSide: BorderSide(width: 3, color: primaryColor),
    ),
  ),

  /// **ListTile**
  listTileTheme: ListTileThemeData(
    iconColor: accentColor,
    textColor: Colors.black87,
    tileColor: const Color.fromARGB(255, 245, 240, 235),
  ),

  /// **Dialogs & BottomSheet**
  dialogTheme: DialogTheme(
    backgroundColor: const Color.fromARGB(255, 245, 240, 235),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    titleTextStyle: TextStyle(
        fontSize: 20, fontWeight: FontWeight.bold, color: accentColor),
    contentTextStyle: const TextStyle(fontSize: 16, color: Colors.black87),
  ),
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: Color.fromARGB(255, 245, 240, 235),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
  ),

  /// **Elevated Button**
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      fixedSize: const Size(180, 50),
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
    ),
  ),
  /// **Text Button**
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: accentColor,
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
    ),
  ),
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: primaryColor,
  scaffoldBackgroundColor: const Color.fromARGB(255, 54, 38, 32),
  colorScheme: ColorScheme.dark(
    primary: primaryColor,
    onPrimary: Colors.white,
    secondary: accentColor,
    onSecondary: Colors.white,
    error: Colors.redAccent,
    onError: Colors.black,
    tertiary: Colors.grey[800]!,
    surface: Colors.grey[900]!,
    onSurface: Colors.white70,
  ),

  /// **Tooltip**
  tooltipTheme: TooltipThemeData(
    decoration: BoxDecoration(
      color: Colors.grey[800],
      borderRadius: BorderRadius.circular(8),
    ),
    textStyle: const TextStyle(color: Colors.white),
    padding: const EdgeInsets.all(8.0),
  ),

  /// **AppBar**
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.black,
    foregroundColor: Colors.white,
    elevation: 2,
    centerTitle: true,
    titleTextStyle: const TextStyle(
        fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
  ),

  /// **Card**
  cardTheme: CardTheme(
    color: const Color.fromARGB(255, 41, 29, 24),
    elevation: 4,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  ),

  /// **TabBar**
  tabBarTheme: TabBarTheme(
    labelColor: primaryColor,
    unselectedLabelColor: Colors.white70,
    indicator: UnderlineTabIndicator(
      borderSide: BorderSide(width: 3, color: primaryColor),
    ),
  ),

  /// **ListTile**
  listTileTheme: ListTileThemeData(
    iconColor: primaryColor,
    textColor: Colors.white70,
    tileColor: const Color.fromARGB(255, 41, 29, 24),
  ),

  /// **Dialogs & BottomSheet**
  dialogTheme: DialogTheme(
    backgroundColor: const Color.fromARGB(255, 41, 29, 24),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    titleTextStyle: const TextStyle(
        fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
    contentTextStyle: const TextStyle(fontSize: 16, color: Colors.white70),
  ),
  bottomSheetTheme: BottomSheetThemeData(
    backgroundColor: const Color.fromARGB(255, 41, 29, 24),
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
  ),

  /// **Elevated Button**
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      fixedSize: const Size(180, 50),
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
    ),
  ),
);
