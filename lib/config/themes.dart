import 'package:flutter/material.dart';

class ConfigThemes {
  static final ocean = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.cyan,
      brightness: Brightness.dark,
    ),
  );

  static final desert = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.orangeAccent,
      brightness: Brightness.dark,
    ),
  );

  static final forest = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.lightGreen,
      brightness: Brightness.dark,
    ),
  );
}

class ThemeController extends ChangeNotifier {
  ThemeData _theme = ConfigThemes.forest;

  ThemeData get theme => _theme;

  void setTheme(ThemeData theme) {
    _theme = theme;
    notifyListeners();
  }
}
