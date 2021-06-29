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
      backgroundColor: Colors.grey[200],
      body: Center(
        child: _selectedTabIndex == 0 ? MoviesTab() : FindMoviesTab(),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: _buildFloatingActionButton(context),
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return _selectedTabIndex == 0
        ? FloatingActionButton(
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
              size: 26.0,
              color: Colors.white,
            ),
          )
        : Container();
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
                label: 'Peliculas',
                // backgroundColor: Colors.red,
                activeIcon: Icon(Icons.movie),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search_rounded),
                activeIcon: Icon(Icons.search_rounded),
                label: 'Buscar',
              )
            ],
            selectedFontSize: 16.0,
            currentIndex: _selectedTabIndex,
            selectedItemColor: Colors.yellow[900],
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
