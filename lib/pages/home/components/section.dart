import 'package:flutter/material.dart';

import '../../../components/text.dart';
import '../../../config/extensions.dart';

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
    final hasGradient = previous != null || next != null;
    final topColor = previous == null ? color : _blend(previous!, color);
    final bottomColor = next == null ? color : _blend(color, next!);

    return Container(
      decoration: BoxDecoration(
        color: hasGradient ? null : color,
        gradient: hasGradient
            ? LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [topColor, color, color, bottomColor],
                stops: const [0, 0.18, 0.82, 1],
              )
            : null,
      ),
      height: height,
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

  Color _blend(Color from, Color to) => Color.lerp(from, to, 0.5)!;
}
