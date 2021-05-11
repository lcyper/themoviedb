import 'package:flutter/material.dart';
import 'package:themoviedb/class/Movies.dart';

class MovieDescription extends StatelessWidget {
  final Movies movie;
  const MovieDescription({Key key, @required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Descripcion:',
            textScaleFactor: 1.6,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Text(
          movie.description,
          // textAlign: TextAlign.justify,
          textScaleFactor: 1.4,
          style: TextStyle(
            letterSpacing: 1.5,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}
