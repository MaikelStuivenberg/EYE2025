import 'package:eye2025/app/app.dart';
import 'package:flutter/material.dart';
import 'package:eye2025/app/injection.dart' as get_it_injection;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  get_it_injection.init();

  runApp(const App());
}
