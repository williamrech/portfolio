import 'package:flutter/material.dart';

import '../../../components/text.dart';
import '../../../config/extensions.dart';
import 'section_background.dart';

class HomeSection extends StatelessWidget {
  const HomeSection({
    super.key,
    required this.title,
    required this.subtitle,
    required this.height,
    required this.color,
    this.previous,
    this.next,
  });

  final String title;
  final String subtitle;
  final double height;
  final Color color;
  final Color? previous;
  final Color? next;

  @override
  Widget build(BuildContext context) {
    final c = context.theme;

    return HomeSectionBackground(
      height: height,
      color: color,
      previous: previous,
      next: next,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 720),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppText(title, size: .s36, color: c.text, weight: .bold),
            const SizedBox(height: 12),
            AppText(subtitle, size: .s20, color: c.text, weight: .regular),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
