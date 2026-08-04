import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'colors.dart';
import 'themes.dart';

extension ThemeContext on BuildContext {
  ThemeData get theme => watch<ThemeController>().theme;

  AppColors get colors => AppColors(theme.colorScheme);

  void setTheme(ThemeData theme) {
    read<ThemeController>().setTheme(theme);
  }
}
