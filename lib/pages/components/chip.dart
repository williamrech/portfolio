import 'package:flutter/material.dart';

import '../../config/extensions.dart';

class HomeChip extends StatelessWidget {
  const HomeChip(this.label, {super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final s = context.styles;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: c.primaryContainer,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Text(label, style: s.chipLabel),
      ),
    );
  }
}
