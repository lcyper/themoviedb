import 'package:flutter/material.dart';
import 'package:themoviedb/screens/widgets/getMovies.dart';

class MoviesTab extends StatefulWidget {
  @override
  _MoviesTabState createState() => _MoviesTabState();
}

class _MoviesTabState extends State<MoviesTab> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Column(
        children: [
          SizedBox(
            height: 40.0,
            child: TabBar(
              indicatorColor: Colors.yellow,
              indicatorWeight: 5.0,
              unselectedLabelColor: Colors.grey[200],
              indicatorPadding: EdgeInsets.only(
                left: 50.0,
                right: 50.0,
              ),
              labelStyle: TextStyle(fontWeight: FontWeight.bold),
              unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
              tabs: [
                Tab(
                  child: Text(
                    'Populares',
                    style: _textStyleLabels,
                  ),
                ),
                Tab(
                  child: Text(
                    'Mejor Puntuadas',
                    style: _textStyleLabels,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              physics: BouncingScrollPhysics(),
              children: [
                getMoviesPage('movie/popular'),
                getMoviesPage('movie/top_rated'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  TextStyle _textStyleLabels = TextStyle(
    color: Colors.black,
    fontSize: 20.0,
  );
}
