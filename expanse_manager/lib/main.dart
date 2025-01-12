import 'package:expanse_manager/pages/home_page.dart';
import 'package:expanse_manager/providers/expanse_provider.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await initLocalStorage();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => ExpenseProvider()), // Provide here!
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  static const primaryColor = Color.fromARGB(255, 30, 59, 59);
  static const accentColor = Color(0xFF609B9B);
  static const backgroundColor = Color(0xFFF2F8F8);
  static const errorColor = Color(0xFFE57373);
  static const textColor = Color(0xFF34495E);
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primaryColor: const Color(0xff2E1065),
          colorScheme: ColorScheme.fromSeed(
            secondary: Colors.white,
              seedColor: const Color(0xff2E1065)), // Recommended for Material 3
          useMaterial3: true, // Enable Material 3 if desired

          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xff2E1065),
            foregroundColor: Colors.white, // Text color on AppBar
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            iconTheme: IconThemeData(color: Colors.white),
          ),

          // Alert Dialog Theme
          dialogTheme: DialogTheme(
            backgroundColor: Colors.white,
            titleTextStyle: const TextStyle(
              color: Color(0xff2E1065),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            contentTextStyle: const TextStyle(color: Colors.black87),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),

          // TabBar Theme
          tabBarTheme: const TabBarTheme(
            indicator: UnderlineTabIndicator(
              // Or use BoxDecoration for more customization
              borderSide: BorderSide(
                  color: Color.fromARGB(255, 166, 149, 197), width: 2.0),
            ),
            labelColor:
                Color.fromARGB(255, 255, 255, 255), // Selected tab color

            unselectedLabelColor: Colors.grey, // Unselected tab color
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
          ),

          // Floating Action Button Theme
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Color(0xff2E1065),
            foregroundColor: Colors.white,
            elevation: 4,
          ),

          // Elevated Button Theme
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff2E1065),
                foregroundColor: Colors.white,
                textStyle:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8))),
          ),

          // Text Button Theme
          textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                  foregroundColor: const Color(0xff2E1065),
                  textStyle: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w500))),

// Outlined Button Theme
          outlinedButtonTheme: OutlinedButtonThemeData(
              style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xff2E1065),
                  side: const BorderSide(color: Color(0xff2E1065), width: 2),
                  textStyle: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w500))),
          // Card Theme
          cardTheme: CardTheme(
            color: Colors.white,
            elevation: 4.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(
                    color: const Color(0xff2E1065).withOpacity(0.2))),
          ),
          // Input Decoration Theme
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Colors.white,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            enabledBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: Color(0xff2E1065), width: 1),
                borderRadius: BorderRadius.circular(8)),
            focusedBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: Color(0xff2E1065), width: 2),
                borderRadius: BorderRadius.circular(8)),
            errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.red, width: 1),
                borderRadius: BorderRadius.circular(8)),
            focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.red, width: 2),
                borderRadius: BorderRadius.circular(8)),
            labelStyle: const TextStyle(color: Color(0xff2E1065), fontSize: 14),
            errorStyle: const TextStyle(color: Colors.red, fontSize: 12),
          ),
        ),
        home:  const HomePage(),
        );
  }
}
