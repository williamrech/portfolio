import 'package:flutter/material.dart';

import '../../../components/text.dart';
import '../../../config/extensions.dart';
import 'section_background.dart';

class HelloSection extends StatefulWidget {
  const HelloSection({
    super.key,
    required this.height,
    required this.color,
    this.previous,
    this.next,
  });

  final double height;
  final Color color;
  final Color? previous;
  final Color? next;

  @override
  State<HelloSection> createState() => _HelloSectionState();
}

class _HelloSectionState extends State<HelloSection> {
  @override
  Widget build(BuildContext context) {
    final c = context.theme;

    return HomeSectionBackground(
      height: widget.height,
      color: widget.color,
      previous: widget.previous,
      next: widget.next,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 1120),
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppText(
                  'William Rech',
                  size: .s36,
                  color: c.text,
                  weight: .bold,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                AppText(
                  'Software Engineer',
                  size: .s20,
                  color: c.text,
                  weight: .regular,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
