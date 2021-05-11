import 'package:flutter/material.dart';
import 'package:themoviedb/screens/pages/favoritesPage.dart';
import 'package:themoviedb/screens/widgets/findMoviesTab.dart';
import 'package:themoviedb/screens/widgets/moviesTab.dart';
// import 'package:themoviedb/class/Movies.dart';

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
      bottomNavigationBar: _buildBottomNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        tooltip: 'Favoritos',
        elevation: 3.0,
        mini: true,
        backgroundColor: Colors.red,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FavoritesPage(),
            ),
          );
        },
        child: Icon(
          Icons.favorite,
          size: 30.0,
          // color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          topLeft: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black38,
            spreadRadius: 0,
            blurRadius: 7,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        child: BottomAppBar(
          notchMargin: 5.0,
          shape: CircularNotchedRectangle(),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.grey[180],
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.movie_outlined),
                label: 'pelis',
                // backgroundColor: Colors.red,
                activeIcon: Icon(Icons.movie),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.find_in_page_outlined),
                activeIcon: Icon(Icons.find_in_page),
                label: 'buscar',
              )
            ],
            selectedFontSize: 16.0,
            currentIndex: _selectedTabIndex,
            selectedItemColor: Colors.yellow[700],
            elevation: 1.0,
            iconSize: 30.0,
            unselectedItemColor: Colors.grey[400],
            onTap: _onBottomMenuTapped,
            // showSelectedLabels: false,
            showUnselectedLabels: false,
          ),
        ),
      ),
    );
  }

  void _onBottomMenuTapped(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }
}
