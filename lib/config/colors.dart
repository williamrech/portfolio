import 'package:flutter/material.dart';

class AppColors {
  const AppColors(this._scheme);

  final ColorScheme _scheme;

  Color get background => _scheme.surface;

  Color get card => _scheme.surfaceContainerHighest;

  Color get cardBorder => _scheme.outlineVariant;

  Color get text => _scheme.onSurface;

  Color get textMuted => _scheme.onSurfaceVariant;

  Color get cardTitle => text;

  Color get cardContent => textMuted;

  Color get chip => _scheme.primaryContainer;

  Color get chipText => _scheme.onPrimaryContainer;

  Color get danger => _scheme.error;
}
