import 'package:flutter/material.dart';

import '../../config/extensions.dart';

class HomeCard extends StatelessWidget {
  const HomeCard({super.key, required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final s = context.styles;

    return SizedBox(
      width: 220,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: s.cardTitle),
              const SizedBox(height: 8),
              Text(body, style: s.cardBody),
            ],
          ),
        ),
      ),
    );
  }
}
