import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDark = true;
  bool get isDark => _isDark;

  ThemeProvider() {
    Future.microtask(() => loadCurrentTheme());
  }

  loadCurrentTheme() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    _isDark = pref.getBool("isDark") ?? true;
    notifyListeners();
  }

  toggleTheme() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    _isDark = !_isDark;
    pref.setBool("isDark", isDark);
    notifyListeners();
  }
}
