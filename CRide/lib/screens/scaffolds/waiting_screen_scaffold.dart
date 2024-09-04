import 'package:app/screens/help_screen.dart';
import 'package:app/screens/select_route.dart';
import 'package:app/screens/settings_screen.dart';
import 'package:app/screens/waiting_mapscreen.dart';
import 'package:flutter/material.dart';

class WaitingScreenScaffold extends StatefulWidget {
  const WaitingScreenScaffold({super.key});

  @override
  State<WaitingScreenScaffold> createState() => _ScreenScaffoldState();
}

class _ScreenScaffoldState extends State<WaitingScreenScaffold> {
  int _currentPage = 0;

  final List<Widget> _pages = [
    const WaitingMapScreen(),
    const RoutesScreen(),
    const SettingsScreen(),
    const HelpScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _pages[_currentPage],
        ],
      ),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  BottomNavigationBar _bottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _currentPage,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      selectedItemColor: Theme.of(context).primaryColor,
      unselectedItemColor: const Color(0xFF6C757D), // Grey
      showUnselectedLabels: true,
      onTap: (index) {
        setState(() {
          _currentPage = index;
        });
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(
            icon: Icon(Icons.directions), label: 'Directions'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        BottomNavigationBarItem(icon: Icon(Icons.help), label: 'Help'),
      ],
    );
  }
}
