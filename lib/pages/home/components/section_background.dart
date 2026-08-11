import 'package:flutter/material.dart';

class HomeSectionBackground extends StatelessWidget {
  const HomeSectionBackground({
    super.key,
    required this.height,
    required this.color,
    required this.child,
    this.previous,
    this.next,
    this.alignment = Alignment.center,
    this.padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
  });

  final double height;
  final Color color;
  final Color? previous;
  final Color? next;
  final AlignmentGeometry alignment;
  final EdgeInsetsGeometry padding;
  final Widget child;

  @override
  Widget build(BuildContext context) {
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
      alignment: alignment,
      padding: padding,
      child: child,
    );
  }

  Color _blend(Color from, Color to) => Color.lerp(from, to, 0.5)!;
}
