import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {

  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;

  ThemeProvider(context) {
    _isDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;
  }

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}