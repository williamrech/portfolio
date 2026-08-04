import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'config/theme.dart';
import 'pages/home.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AppThemeController())],
      child: const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: const Home());
  }
}
