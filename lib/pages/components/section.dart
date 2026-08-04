import 'package:flutter/material.dart';

import '../../components/text.dart';
import '../../config/extensions.dart';

class HomeSection extends StatelessWidget {
  const HomeSection({
    super.key,
    required this.title,
    required this.subtitle,
    required this.backgroundColor,
  });

  final String title;
  final String subtitle;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    final c = context.theme;

    return Container(
      color: backgroundColor,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
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
