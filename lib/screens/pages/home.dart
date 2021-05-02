import 'package:flutter/material.dart';
import 'package:themoviedb/helpers/home_widgets_handler.dart';
import 'package:themoviedb/screens/widgets/findMoviesTab.dart';
import 'package:themoviedb/screens/widgets/moviesTab.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _selectedTabIndex == 0 ? MoviesTab() : FindMoviesTab(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.movie_outlined),
            label: 'pelis',
            backgroundColor: Colors.black,
            activeIcon: Icon(Icons.movie),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.find_in_page_outlined),
            activeIcon: Icon(Icons.find_in_page),
            label: 'buscar',
          )
        ],
        currentIndex: _selectedTabIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey[400],
        onTap: _onBottomMenuTapped,
        // showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
    );
  }

  void _onBottomMenuTapped(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }
}
