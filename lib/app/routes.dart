import 'package:eye2025/features/home/home_page.dart';
import 'package:eye2025/features/map/map.dart';
import 'package:eye2025/features/program/program_page.dart';
import 'package:eye2025/features/splash/pages/splash.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const SplashPage());
      case '/home':
        return MaterialPageRoute(builder: (_) => const HomePage());
      case '/program':
        return MaterialPageRoute(builder: (_) => const ProgramPage());
      case '/map':
        return MaterialPageRoute(builder: (_) => const MapPage());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
