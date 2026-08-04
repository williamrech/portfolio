import 'package:flutter/material.dart';
import 'package:portfolio/config/theme.dart';
import 'package:provider/provider.dart';

extension AppThemeContext on BuildContext {
  AppTheme get theme => watch<AppThemeController>().theme;

  void setTheme(AppTheme theme) {
    read<AppThemeController>().setTheme(theme);
  }
}
