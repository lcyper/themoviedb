import 'package:flutter/material.dart';
import 'package:themoviedb/screens/widgets/getMovies.dart';

class MoviesTab extends StatefulWidget {
  @override
  _MoviesTabState createState() => _MoviesTabState();
}

class _MoviesTabState extends State<MoviesTab> {
  Widget tabSelected = popular();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            TextButton(
              onPressed: () {
                setState(() {
                  tabSelected = popular();
                });
              },
              child: Text(
                'Populares',
                style: _textStyleLabels,
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  tabSelected = mostView();
                });
              },
              child: Text(
                'Mejor Puntuadas',
                style: _textStyleLabels,
              ),
            ),
          ],
        ),
      ),
      body: tabSelected,
    );
  }

  TextStyle _textStyleLabels = TextStyle(
    fontWeight: FontWeight.w900,
    color: Colors.black,
    fontStyle: FontStyle.italic,
    fontSize: 15.0,
    decoration: TextDecoration.underline,
    decorationColor: Colors.yellow,
    decorationThickness: 2.0,
  );
}
