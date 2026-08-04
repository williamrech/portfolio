import 'package:flutter/material.dart';

import '../components/text.dart';
import '../config/extensions.dart';
import '../config/themes.dart';
import 'components/card.dart';
import 'components/chip.dart';
import 'components/radio.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final c = context.colors;

    return Scaffold(
      appBar: AppBar(
        title: AppText('Portfolio', size: .s20, color: c.text, weight: .bold),
        actions: [
          RadioGroup<ThemeData>(
            groupValue: theme,
            onChanged: (value) => context.setTheme(value!),
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Wrap(
                spacing: 8,
                children: [
                  HomeRadio(theme: ConfigThemes.ocean, label: 'Ocean'),
                  HomeRadio(theme: ConfigThemes.desert, label: 'Desert'),
                  HomeRadio(theme: ConfigThemes.forest, label: 'Forest'),
                ],
              ),
            ),
          ),
        ],
      ),
      body: ColoredBox(
        color: c.background,
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: c.card,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: c.cardBorder),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    'William Rech',
                    size: .s36,
                    color: c.text,
                    weight: .bold,
                  ),
                  const SizedBox(height: 8),
                  AppText(
                    'Software engineer building useful products.',
                    size: .s16,
                    color: c.textMuted,
                    weight: .regular,
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: const [
                      HomeChip('Flutter'),
                      HomeChip('Backend'),
                      HomeChip('Product'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: const [
                HomeCard(title: 'Projects', body: 'Selected work'),
                HomeCard(title: 'Experience', body: 'Roles and impact'),
                HomeCard(title: 'Contact', body: 'Ways to reach me'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
