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
      length: 2, //3
      child: Column(
        children: [
          SizedBox(
            height: 40.0,
            child: _buildTabBar(),
          ),
          Expanded(
            child: TabBarView(
              // physics: BouncingScrollPhysics(),
              children: [
                // Icon(Icons.favorite_border),
                getMoviesPage('movie/popular'),
                getMoviesPage('movie/top_rated'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  TabBar _buildTabBar() {
    return TabBar(
      indicatorColor: Colors.yellow,
      indicatorWeight: 5.0,
      indicatorPadding: EdgeInsets.only(
        left: 50.0,
        right: 50.0,
      ),
      labelStyle: TextStyle(fontWeight: FontWeight.bold),
      unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
      tabs: [
        // Tab(
        //   icon: Icon(
        //     Icons.favorite,
        //   ),
        // ),
        Tab(
          child: Text(
            'Populares',
            style: _textStyleTab,
          ),
        ),
        Tab(
          child: Text(
            'Mejor Puntuadas',
            style: _textStyleTab,
          ),
        ),
      ],
    );
  }

  TextStyle _textStyleTab = TextStyle(
    color: Colors.black,
    fontSize: 20.0,
  );
}
