import 'package:flutter/material.dart';

import '../../components/text.dart';
import '../../config/extensions.dart';

class HomeChip extends StatelessWidget {
  const HomeChip(this.label, {super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: c.chip,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: AppText(label, size: .s12, color: c.chipText, weight: .medium),
      ),
    );
  }
}
