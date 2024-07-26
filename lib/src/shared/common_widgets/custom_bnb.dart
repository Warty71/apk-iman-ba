import 'package:apk_iman_ba/src/features/favorites/presentation/pages/favorites_page.dart';
import 'package:apk_iman_ba/src/features/home/presentation/home_page.dart';
import 'package:apk_iman_ba/src/features/profile/presentation/pages/user_page.dart';
import 'package:apk_iman_ba/src/features/search/presentation/pages/search_page.dart';

import 'package:flutter/material.dart';

class CustomBNB extends StatefulWidget {
  const CustomBNB({super.key});

  @override
  State<CustomBNB> createState() => _CustomBNBState();
}

class _CustomBNBState extends State<CustomBNB> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const SearchPage(),
    const FavoritesPage(),
    const UserPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: SafeArea(
        top: false,
        child: Scaffold(
          body: _pages[_currentIndex],
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
            child: Container(
              padding: const EdgeInsets.all(4.0),
              margin: const EdgeInsets.symmetric(horizontal: 24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const RadialGradient(
                  center: Alignment(-1.538, -3.615),
                  radius: 4,
                  colors: <Color>[Color(0xff5959e4), Color(0xff140632)],
                  stops: <double>[0, 0.99],
                ),
              ),
              child: BottomNavigationBar(
                currentIndex: _currentIndex,
                onTap: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                backgroundColor: Colors.transparent,
                selectedItemColor: Colors.white,
                unselectedItemColor: Colors.white54,
                type: BottomNavigationBarType.fixed,
                showSelectedLabels: false, // Hide labels for selected items
                showUnselectedLabels: false, // Hide labels for unselected items
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home_outlined),
                    label: "Home",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.search),
                    label: "Search",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.favorite_border),
                    label: "Favorites",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person_4_outlined),
                    label: "User",
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
