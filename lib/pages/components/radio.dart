import 'package:flutter/material.dart';

import '../../config/extensions.dart';

class HomeRadio extends StatelessWidget {
  const HomeRadio({super.key, required this.theme, required this.label});

  final ThemeData theme;
  final String label;

  @override
  Widget build(BuildContext context) {
    final s = context.styles;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio<ThemeData>(value: theme),
        Text(label, style: s.themeOption),
      ],
    );
  }
}
