import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ThemeClass {
  final ThemeData lightTheme = ThemeData(
      fontFamily: "jakarta_sans",
      brightness: Brightness.light,
      primaryColor: Colors.lightBlue.shade700,
      // accentColor: Colors.orange,
      scaffoldBackgroundColor: const Color.fromARGB(255, 225, 231, 253),
      // backgroundColor: Colors.grey.shade100,
      appBarTheme: AppBarTheme(
        color: Colors.lightBlue.shade700,
        foregroundColor: Colors.white,
      ),
      textTheme: TextTheme(
        bodySmall: const TextStyle(color: Colors.black),
        bodyMedium: TextStyle(color: Colors.grey.shade800),
      ),
      cardColor: const Color.fromARGB(255, 212, 221, 252),
      inputDecorationTheme: InputDecorationTheme(
          fillColor: Colors.black,
          focusColor: Colors.black,
          hoverColor: Colors.black,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  const BorderSide(width: 2.0, style: BorderStyle.solid)))
      // errorColor: Colors.red,
      );

  final ThemeData darkTheme = ThemeData(
      fontFamily: "jakarta_sans",
      brightness: Brightness.dark,
      primaryColor: Colors.blueGrey.shade900,
      // accentColor: Colors.orange,
      scaffoldBackgroundColor: Colors.grey.shade900,
      // backgroundColor: Colors.grey.shade800,
      appBarTheme: const AppBarTheme(
        color: Color.fromARGB(255, 57, 59, 59),
        foregroundColor: Colors.white,
      ),
      textTheme: TextTheme(
        bodySmall: const TextStyle(color: Colors.white),
        bodyMedium: TextStyle(color: Colors.grey.shade400),
      ),
      // errorColor: Colors.red,
      listTileTheme: ListTileThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          tileColor: Color.fromARGB(255, 57, 59, 59)),
      // cardColor: const ,
      inputDecorationTheme: InputDecorationTheme(
          fillColor: Colors.white,
          focusColor: Colors.white,
          hoverColor: Colors.white,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  const BorderSide(width: 2.0, style: BorderStyle.solid))));
}
