import 'package:flutter/material.dart';
import 'package:themoviedb/class/Movies.dart';

Widget popular() {
  // return Text('hey bro');
  return FutureBuilder<Widget>(
    future: Movies().getMovies(url: 'popular'),
    builder: (context, snapshot) => snapshot.hasData
        ? snapshot.data
        : Center(child: CircularProgressIndicator()),
  );
}

Widget mostView() => Column(
      children: [Text('peliculas mas vistas')],
    );
