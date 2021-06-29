import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:themoviedb/class/Movies.dart';
import 'package:themoviedb/provider/cacheApp.dart';

class FavoritesPage extends StatefulWidget {
  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    // cambiar y traer desde el provider
    // List<Movies> movies = Movies().getFavoriteMovies;
    List<Movies> movies = Provider.of<CacheApp>(context).favoriteMovies;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        extendBody: true,
        // extendBodyBehindAppBar: true,
        appBar: _buildAppBar(context),
        body: createListView(movies, type: "favorite"),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text('Peliculas Favoritas'),
      centerTitle: true,
      automaticallyImplyLeading: false,
      // toolbarHeight: 40.0,
      // foregroundColor: Colors.black,
      elevation: 0.0,
      // backgroundColor: Colors.transparent,
      backgroundColor: Colors.black12,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
            // size: 30.0,
          ),
          style: ElevatedButton.styleFrom(
            shape: CircleBorder(),
            padding: EdgeInsets.all(1.0),
            minimumSize: Size.square(1.0),
            fixedSize: Size(3, 3),
            primary: Colors.black45,
          ),
        ),
      ),
    );
  }
}
