import 'package:flutter/material.dart';

import '../components/text.dart';
import '../config/extensions.dart';
import '../config/theme.dart';
import 'components/radio.dart';
import 'components/section.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final c = context.theme;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: c.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        shadowColor: c.transparent,
        surfaceTintColor: c.transparent,
        title: AppText('Portfolio', size: .s20, color: c.text, weight: .bold),
        actions: [
          RadioGroup<AppTheme>(
            groupValue: c,
            onChanged: (value) => context.setTheme(value!),
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Wrap(
                spacing: 8,
                children: [
                  HomeRadio(theme: AppThemes.ocean, label: 'Ocean'),
                  HomeRadio(theme: AppThemes.desert, label: 'Desert'),
                  HomeRadio(theme: AppThemes.forest, label: 'Forest'),
                ],
              ),
            ),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final sectionHeight = constraints.maxHeight;

          return ListView(
            padding: EdgeInsets.zero,
            children: [
              SizedBox(
                height: sectionHeight,
                child: HomeSection(
                  title: 'Hello',
                  subtitle: 'Software Engineer',
                  backgroundColor: c.backDark,
                ),
              ),
              SizedBox(
                height: sectionHeight,
                child: HomeSection(
                  title: 'Featured Projects',
                  subtitle: 'My favorite work',
                  backgroundColor: c.backLight,
                ),
              ),
              SizedBox(
                height: sectionHeight,
                child: HomeSection(
                  title: 'Journey',
                  subtitle: 'My experience',
                  backgroundColor: c.backDark,
                ),
              ),
              SizedBox(
                height: sectionHeight,
                child: HomeSection(
                  title: 'Technical Toolbox',
                  subtitle: 'Technologies & Architecture',
                  backgroundColor: c.backLight,
                ),
              ),
              SizedBox(
                height: sectionHeight,
                child: HomeSection(
                  title: "Let's Connect",
                  subtitle: 'Contact',
                  backgroundColor: c.backDark,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
