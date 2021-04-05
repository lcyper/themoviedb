import 'package:flutter/material.dart';
import 'package:themoviedb/screens/widgets/findMoviesTab.dart';
import 'package:themoviedb/screens/widgets/moviesTab.dart';

Widget homeWidgetsHandler(selectedIndex) {
  if (selectedIndex == 0) {
    // es home - pelis
    return MoviesTab();
  } else {
    // es home - buscador
    return FindMoviesTab();
  }
}
