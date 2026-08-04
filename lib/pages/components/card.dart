import 'package:flutter/material.dart';

import '../../components/text.dart';
import '../../config/extensions.dart';

class HomeCard extends StatelessWidget {
  const HomeCard({super.key, required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;

    return SizedBox(
      width: 220,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(title, size: .s16, color: c.cardTitle, weight: .medium),
              const SizedBox(height: 8),
              AppText(body, size: .s14, color: c.cardContent, weight: .regular),
            ],
          ),
        ),
      ),
    );
  }
}
