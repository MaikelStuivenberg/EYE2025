import 'package:eye2025/shared/widgets/eye_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:eye2025/shared/widgets/eye_app_bar.dart';

class EyeScaffold extends StatelessWidget {
  final Widget body;
  final Widget? floatingActionButton;
  final bool bottomNavigationBar;
  final String title;

  const EyeScaffold({
    super.key,
    required this.body,
    this.floatingActionButton,
    this.bottomNavigationBar = false,
    this.title = 'Default Title',
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EyeAppBar(title: title),
      body: body,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: EyeBottomNavigationBar(),
    );
  }
}
