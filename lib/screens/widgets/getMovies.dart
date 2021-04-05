import 'package:flutter/material.dart';
import 'package:themoviedb/class/Movies.dart';

Widget popular() {
  Movies().popular();
  return Column(
    children: [Text('peliculas populares')],
  );
}

Widget mostView() => Column(
      children: [Text('peliculas mas vistas')],
    );
