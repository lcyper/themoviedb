import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:themoviedb/class/Movies.dart';
import 'package:themoviedb/screens/widgets/createCard.dart';

class MovieCardPage extends StatelessWidget {
  final Movies movie;

  const MovieCardPage({Key key, this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Movies().getMovies(id: movie.id, buildContext:context))
    return Scaffold(
      // extendBody: true,
      extendBodyBehindAppBar: true,
      // backgroundColor: Colors.transparent,
      appBar: AppBar(
        toolbarHeight: 50.0,
        // toolbarOpacity: 0.5,
        foregroundColor: Colors.white,
        // foregroundColor: Colors.black,
        elevation: 0.0,
        backwardsCompatibility: false,
        backgroundColor: Colors.transparent,
        flexibleSpace: FlexibleSpaceBar(
          background: movie.backdropPath != null
              ? Image.network(
                  movie.backdropPath,
                  fit: BoxFit.fitWidth,
                  cacheHeight: 200,
                  height: 200.0,
                )
              : SizedBox(
                  height: 200,
                ),
        ),
        // Container(
        //   height: 200.0,
        //   decoration: BoxDecoration(
        //     image: DecorationImage(
        //       image: NetworkImage(
        //         movie.backdropPath,
        //         // fit: BoxFit.fitWidth,
        //         // cacheHeight: 200,
        //         // height: 200.0,
        //       ),
        //       fit: BoxFit.cover,
        //     ),
        //   ),
        // ),
      ),
      body: _buildWidget(),
    );
  }

  Widget _buildWidget() {
    // if (widgets != null)
    // Column(
    //   crossAxisAlignment: CrossAxisAlignment.center,
    //   mainAxisAlignment: MainAxisAlignment.center,
    //   mainAxisSize: MainAxisSize.max,
    //   children: [Divider(), ...widgets],
    // ),

    final List<Widget> widgets = [
      Text(
        movie.description,
        textScaleFactor: 1.3,
        textWidthBasis: TextWidthBasis.longestLine,
      ),
      Text(
        movie.description,
        textScaleFactor: 1.3,
        textWidthBasis: TextWidthBasis.longestLine,
      ),
      Text(
        movie.description,
        textScaleFactor: 1.3,
        textWidthBasis: TextWidthBasis.longestLine,
      ),
      Text(
        movie.description,
        textScaleFactor: 1.3,
        textWidthBasis: TextWidthBasis.longestLine,
      ),
      movie.getActors(),
    ];
    return ListView(
      scrollDirection: Axis.vertical,
      children: [
        // Image.network(
        //   movie.backdropPath,
        //   fit: BoxFit.fitWidth,
        //   cacheHeight: 200,
        //   height: 200.0,
        // ),
        FutureBuilder(
          initialData: movie,
          future: movie.getMovies(id: movie.id),
          builder: (context, snapshot) => snapshot.hasData
              ? CreateCard(movie: snapshot.data).movieInfoOnly(context, widgets)
              : Center(
                  child: CircularProgressIndicator(),
                ),
        ),
      ],
    );
  }
}
