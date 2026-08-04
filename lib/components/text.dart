import 'package:flutter/material.dart';

enum AppTextSize {
  s12(12),
  s14(14),
  s16(16),
  s20(20),
  s24(24),
  s36(36);

  const AppTextSize(this.value);

  final double value;
}

enum AppTextWeight {
  regular(FontWeight.w400),
  medium(FontWeight.w500),
  semiBold(FontWeight.w600),
  bold(FontWeight.w700);

  const AppTextWeight(this.value);

  final FontWeight value;
}

class AppText extends StatelessWidget {
  const AppText(
    this.data, {
    super.key,
    required this.size,
    required this.color,
    required this.weight,
    this.textAlign,
    this.maxLines,
    this.overflow,
  });

  final String data;
  final AppTextSize size;
  final Color color;
  final AppTextWeight weight;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      style: TextStyle(
        color: color,
        fontSize: size.value,
        fontWeight: weight.value,
      ),
    );
  }
}
