import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDark = false;
  bool _isLoading = false;
  bool get isDark => _isDark;
  bool get isLoading => _isLoading;

  ThemeProvider() {
    _loadTheme(); // Call async function without `await`
  }

  Future<void> _loadTheme() async {
    _isLoading = true;
    SharedPreferences pref = await SharedPreferences.getInstance();
    _isDark = pref.getBool('isDark') ?? false;
    _isLoading = false;
    notifyListeners();
  }

  void changeTheme() async {
    _isDark = !_isDark;
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setBool("isDark", _isDark);
    notifyListeners();
  }
}
