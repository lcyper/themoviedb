import 'package:flutter/material.dart';
import 'package:themoviedb/class/Movies.dart';

class FavoritesPage extends StatefulWidget {
  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> favorites = Movies().getCacheDataApi()['favorite'];
    List<Movies> movies = [];
    favorites.forEach((key, value) {
      Movies movie = Movies.fromJson(value);
      movies.add(movie);
    });

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        extendBody: true,
        // extendBodyBehindAppBar: true,
        // backgroundColor: Colors.transparent,
        appBar: AppBar(
            title: Text('Favoritas'),
            centerTitle: true,
            automaticallyImplyLeading: false,
            // toolbarHeight: 40.0,
            // foregroundColor: Colors.black,
            elevation: 0.0,
            backgroundColor: Colors.transparent,
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
            )),
        body: createListView(movies),
      ),
    );
  }
}
