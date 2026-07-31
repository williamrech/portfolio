import 'package:flutter/material.dart';

class ConfigStyles {
  ConfigStyles({required TextTheme text, required ColorScheme colors})
    : appTitle = text.titleLarge!.copyWith(color: colors.onSurface),
      heroTitle = text.displaySmall!.copyWith(
        color: colors.onSurface,
        fontWeight: FontWeight.w700,
      ),
      heroSubtitle = text.titleMedium!.copyWith(color: colors.onSurfaceVariant),
      chipLabel = text.labelMedium!.copyWith(color: colors.onPrimaryContainer),
      cardTitle = text.titleMedium!.copyWith(color: colors.onSurface),
      cardBody = text.bodyMedium!.copyWith(color: colors.onSurfaceVariant),
      themeOption = text.labelMedium!.copyWith(color: colors.onSurface);

  final TextStyle appTitle;
  final TextStyle heroTitle;
  final TextStyle heroSubtitle;
  final TextStyle chipLabel;
  final TextStyle cardTitle;
  final TextStyle cardBody;
  final TextStyle themeOption;
}
