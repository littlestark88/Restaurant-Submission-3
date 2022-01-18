import 'package:flutter/material.dart';
import 'package:restaurant_apps_local/page/favorite_page.dart';
import 'package:restaurant_apps_local/page/home_page.dart';
import 'package:restaurant_apps_local/page/settings_page.dart';

class BottomPage extends StatefulWidget {
  const BottomPage({Key? key}) : super(key: key);

  @override
  _BottomPageState createState() => _BottomPageState();
}

class _BottomPageState extends State<BottomPage> {
  int _bottomNavIndex = 0;

  final List<Widget> _listWidget = [
    const HomePage(),
    const FavoritePage(),
    const SettingsPage(),
  ];

  void _onBottomNavTapped(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _listWidget[_bottomNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _bottomNavIndex,
        items: [
          BottomNavigationBarItem(
              icon: _bottomNavIndex == 0
                  ? const Icon(Icons.home)
                  : const Icon(Icons.home_outlined),
            label: "Home"
          ),
          BottomNavigationBarItem(
              icon: _bottomNavIndex == 1
                  ? const Icon(Icons.favorite)
                  : const Icon(Icons.favorite_border_outlined),
              label: "Favorite"
          ),
          BottomNavigationBarItem(
              icon: _bottomNavIndex == 2
                  ? const Icon(Icons.settings)
                  : const Icon(Icons.settings_outlined),
              label: "Settings"
          ),
        ],
        onTap: _onBottomNavTapped,
      ),
    );
  }
}
