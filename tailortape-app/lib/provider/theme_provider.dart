import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  ThemeMode get themeMode => _themeMode;
  IconData _themeIcon = Icons.light_mode;
  IconData get themeIcon => _themeIcon;
  String _themeName = "Light";
  String get themeName => _themeName;
  IconData _sysThemeCheck = Icons.radio_button_off_sharp;
  IconData get sysThemeCheck => _sysThemeCheck;

  ThemeProvider() {
    _loadTheme();
  }
  void _loadTheme() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String themeMode = pref.getString("themeMode") ?? "ThemeMode.light";
    if (themeMode == "ThemeMode.dark") {
      _themeMode = ThemeMode.dark;
      _themeIcon = Icons.light_mode;
      _themeName = "Dark";
    } else if (themeMode == "ThemeMode.system") {
      _themeMode = ThemeMode.system;
      _themeIcon = Icons.system_update;
      _themeName = "Using System";
      _sysThemeCheck = Icons.radio_button_checked_sharp;
    } else {
      _themeMode = ThemeMode.light;
      _themeIcon = Icons.dark_mode;
      _themeName = "Light";
    }
    notifyListeners();
  }

  void saveData(String myData) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("themeMode", myData).then((bool success) {});
  }

  setTheme(themeMode) {
    _themeMode = themeMode;
    saveData(themeMode.toString());
    notifyListeners();
  }

  setSystemTheme(sysThemeCheck) {
    _sysThemeCheck = sysThemeCheck;
    notifyListeners();
  }

  setThemeIcon(themeIcon) {
    _themeIcon = themeIcon;
    notifyListeners();
  }

  setThemeName(themeName) {
    _themeName = themeName;
    notifyListeners();
  }
}
