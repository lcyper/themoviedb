import 'package:flutter/material.dart';
import 'package:themoviedb/class/Movies.dart';

Widget getMoviesPage(String url, Map cacheDataApi) => FutureBuilder(
      future: Movies().getMovies(url: url, cacheDataApi: cacheDataApi),
      builder: (context, snapshot) => snapshot.hasData
          ? RefreshIndicator(
              onRefresh: () {
                // return Movies().updateMovies(url, cacheDataApi);

              },
              child: createListView(snapshot.data))
          : snapshot.hasError
              ? Center(
                  child: Text(snapshot.error.toString()),
                  // 'Error: no se pudo acceder a los datos, comprueba el internet.'
                )
              : Center(child: CircularProgressIndicator()),
    );
