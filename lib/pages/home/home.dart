import 'package:flutter/material.dart';
import 'package:portfolio/pages/home/home_bloc.dart';

import '../../components/text.dart';
import '../../config/extensions.dart';
import '../../config/theme.dart';
import 'components/behavior.dart';
import 'components/radio.dart';
import 'components/section.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _bloc = HomeBloc();

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = context.theme;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: c.backDark,
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
      body: HomeBehavior(
        bloc: _bloc,
        backgroundColor: c.backDark,
        builder: (context, sectionHeight) => ListView(
          controller: _bloc.scrollController,
          padding: EdgeInsets.zero,
          children: [
            HomeSection(
              title: 'Hello',
              subtitle: 'Software Engineer',
              height: sectionHeight,
              color: c.backDark,
              next: c.backLight,
            ),
            HomeSection(
              title: 'Featured Projects',
              subtitle: 'My favorite work',
              height: sectionHeight,
              color: c.backLight,
              previous: c.backDark,
              next: c.backDark,
            ),
            HomeSection(
              title: 'Journey',
              subtitle: 'My experience',
              height: sectionHeight,
              color: c.backDark,
              previous: c.backLight,
              next: c.backLight,
            ),
            HomeSection(
              title: 'Technical Toolbox',
              subtitle: 'Technologies & Architecture',
              height: sectionHeight,
              color: c.backLight,
              previous: c.backDark,
              next: c.backDark,
            ),
            HomeSection(
              title: "Let's Connect",
              subtitle: 'Contact',
              height: sectionHeight,
              color: c.backDark,
              previous: c.backLight,
            ),
          ],
        ),
      ),
    );
  }
}
