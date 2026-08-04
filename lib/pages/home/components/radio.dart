import 'package:flutter/material.dart';

import '../../../components/text.dart';
import '../../../config/extensions.dart';
import '../../../config/theme.dart';

class HomeRadio extends StatelessWidget {
  const HomeRadio({super.key, required this.theme, required this.label});

  final AppTheme theme;
  final String label;

  @override
  Widget build(BuildContext context) {
    final c = context.theme;
    final selected = identical(c, theme);

    return Material(
      color: c.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(999),
        overlayColor: WidgetStateProperty.all(c.highlight.overlay),
        onTap: () => context.setTheme(theme),
        child: Padding(
          padding: const EdgeInsets.only(right: 12),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Radio<AppTheme>(
                value: theme,
                fillColor: WidgetStateProperty.resolveWith((states) {
                  if (states.contains(WidgetState.selected)) return c.highlight;
                  return c.text;
                }),
                overlayColor: WidgetStateProperty.all(c.transparent),
              ),
              AppText(
                label,
                size: .s14,
                color: selected ? c.highlight : c.text,
                weight: selected ? .semiBold : .regular,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
