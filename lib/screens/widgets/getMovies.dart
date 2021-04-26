import 'package:flutter/material.dart';
import 'package:themoviedb/class/Movies.dart';

Widget getMoviesPage(String url) => FutureBuilder<Widget>(
      future: Movies().getMovies(url: url),
      builder: (context, snapshot) => snapshot.hasData
          ? snapshot.data
          : snapshot.hasError
              ? Center(
                  child: Text(
                      'Error: no se pudo acceder a los datos, comprueba el internet.'),
                )
              : Center(child: CircularProgressIndicator()),
    );
