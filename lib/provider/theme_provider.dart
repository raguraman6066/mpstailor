import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  bool _darkTheme = false;
  bool get darkTheme => _darkTheme;

  changeTheme() {
    _darkTheme = !_darkTheme;
    notifyListeners();
  }
}
