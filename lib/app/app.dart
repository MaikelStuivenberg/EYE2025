import 'package:eye2025/app/routes.dart';
import 'package:eye2025/features/splash/pages/splash.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'European Youth Event 2025',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashPage(),
      onGenerateRoute: Routes.generateRoute,
    );
  }
}
