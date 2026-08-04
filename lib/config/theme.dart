import 'package:flutter/material.dart';

class AppThemes {
  static final ocean = AppTheme(
    transparent: Color(0x00000000),
    backDark: Color(0xFF070F2B),
    backLight: Color(0xFF1B1A55),
    highlight: Color(0xFF00D4FF),
    text: Color(0xFFFFFFFF),
  );

  static final desert = AppTheme(
    transparent: Color(0x00000000),
    backDark: Color(0xFF2F1B12),
    backLight: Color(0xFF5A3A22),
    highlight: Color(0xFFFFB703),
    text: Color(0xFFFFFFFF),
  );

  static final forest = AppTheme(
    transparent: Color(0x00000000),
    backDark: Color(0xFF081C15),
    backLight: Color(0xFF1B4332),
    highlight: Color(0xFF52B788),
    text: Color(0xFFFFFFFF),
  );
}

extension AppThemeColor on Color {
  Color get overlay => withValues(alpha: 0.12);
}

class AppTheme {
  Color transparent;
  Color backDark;
  Color backLight;
  Color highlight;
  Color text;

  AppTheme({
    required this.transparent,
    required this.backDark,
    required this.backLight,
    required this.highlight,
    required this.text,
  });
}

class AppThemeController extends ChangeNotifier {
  AppTheme _theme = AppThemes.ocean;

  AppTheme get theme => _theme;

  void setTheme(AppTheme theme) {
    _theme = theme;
    notifyListeners();
  }
}
