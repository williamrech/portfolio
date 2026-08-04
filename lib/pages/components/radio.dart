import 'package:flutter/material.dart';

import '../../components/text.dart';
import '../../config/extensions.dart';

class HomeRadio extends StatelessWidget {
  const HomeRadio({super.key, required this.theme, required this.label});

  final ThemeData theme;
  final String label;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio<ThemeData>(value: theme),
        AppText(label, size: .s14, color: c.text, weight: .regular),
      ],
    );
  }
}
