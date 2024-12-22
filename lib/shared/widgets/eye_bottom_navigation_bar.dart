import 'package:flutter/material.dart';

class EyeBottomNavigationBar extends StatelessWidget {
  static int currentIndex = 0;

  const EyeBottomNavigationBar({
    super.key,
    // required this.currentIndex,
    // required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'bottom_navigation_bar',
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          currentIndex = index;

          switch (index) {
            case 0:
              Navigator.pushNamed(context, '/home');
              break;
            case 1:
              Navigator.pushNamed(context, '/program');
              break;
            case 2:
              Navigator.pushNamed(context, '/map');
              break;
          }
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: 'Program',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Map',
          ),
        ],
      ),
    );
  }
}
