import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'styles.dart';
import 'themes.dart';

extension ThemeContext on BuildContext {
  ThemeData get theme => watch<ThemeController>().theme;

  ColorScheme get colors => theme.colorScheme;

  TextTheme get text => theme.textTheme;

  ConfigStyles get styles => ConfigStyles(text: text, colors: colors);

  void setTheme(ThemeData theme) {
    read<ThemeController>().setTheme(theme);
  }
}
