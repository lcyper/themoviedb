import 'package:flutter/material.dart';
import 'package:themoviedb/class/Movies.dart';

class MovieCardPage extends StatelessWidget {
  final Movies movie;

  const MovieCardPage({Key key, this.movie}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // Movies().getMovies(id: movie.id, buildContext:context))
    return Scaffold(
      appBar: AppBar(),
      body: Center(child: Text(movie.title)),
    );
  }
}
