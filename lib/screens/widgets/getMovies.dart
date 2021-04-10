import 'package:flutter/material.dart';
import 'package:themoviedb/class/Movies.dart';

Widget popular() => FutureBuilder<Widget>(
    future: Movies().getMovies(url: 'movie/popular'),
    builder: (context, snapshot) => snapshot.hasData
        ? snapshot.data
        : Center(child: CircularProgressIndicator()),
  );


Widget mostView() => FutureBuilder<Widget>(
    future: Movies().getMovies(url: 'movie/top_rated'),
    builder: (context, snapshot) => snapshot.hasData
        ? snapshot.data
        : Center(child: CircularProgressIndicator()),
  );
