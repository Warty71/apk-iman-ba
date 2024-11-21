import 'package:apk_iman_ba/src/features/favorites/presentation/pages/favorites_page.dart';
import 'package:apk_iman_ba/src/features/home/presentation/home_page.dart';
import 'package:apk_iman_ba/src/features/navigation/presentation/cubit/navigation_cubit.dart';
import 'package:apk_iman_ba/src/features/navigation/presentation/cubit/navigation_state.dart';
import 'package:apk_iman_ba/src/features/profile/presentation/pages/user_page.dart';
import 'package:apk_iman_ba/src/features/search/presentation/pages/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomBNB extends StatelessWidget {
  CustomBNB({super.key});

  final List<Widget> _pages = [
    const HomePage(),
    const SearchPage(),
    const FavoritesPage(),
    const UserPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, NavigationState>(
      builder: (context, state) {
        return PopScope(
          canPop: false,
          child: SafeArea(
            top: false,
            child: Scaffold(
              body: _pages[state.currentIndex],
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
                    currentIndex: state.currentIndex,
                    onTap: (index) {
                      context.read<NavigationCubit>().setIndex(index);
                    },
                    backgroundColor: Colors.transparent,
                    selectedItemColor: Colors.white,
                    unselectedItemColor: Colors.white54,
                    type: BottomNavigationBarType.fixed,
                    showSelectedLabels: false,
                    showUnselectedLabels: false,
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
      },
    );
  }
}
