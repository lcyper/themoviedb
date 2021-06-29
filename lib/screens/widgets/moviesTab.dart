import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:themoviedb/provider/cacheApp.dart';
import 'package:themoviedb/screens/widgets/getMovies.dart';

class MoviesTab extends StatefulWidget {
  @override
  _MoviesTabState createState() => _MoviesTabState();
}

class _MoviesTabState extends State<MoviesTab> {
  @override
  Widget build(BuildContext context) {
    Map cacheDataApi = Provider.of<CacheApp>(context).cacheDataApi;
    // if (cacheDataApi.length < 1) {
    //   Provider.of<CacheApp>(context).setup();
    // }

    return cacheDataApi.length < 1 ?
    Center(child: CircularProgressIndicator(),)
    : DefaultTabController(
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
                getMoviesPage('movie/popular', cacheDataApi),
                getMoviesPage('movie/top_rated', cacheDataApi),
              ],
            ),
          ),
        ],
      ),
    );
  }

  TabBar _buildTabBar() {
    return TabBar(
      indicatorColor: Colors.yellow[900],
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
