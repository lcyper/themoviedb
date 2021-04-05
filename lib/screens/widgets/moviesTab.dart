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
          children: [
            FlatButton(
              onPressed: () {
                setState(() {
                  tabSelected = popular();
                });
              },
              color: Colors.white,
              child: Text(
                'Populares',
                style: TextStyle(fontWeight: FontWeight.w900),
              ),
            ),
            FlatButton(
              onPressed: () {
                setState(() {
                  tabSelected = mostView();
                });
              },
              color: Colors.white,
              child: Text(
                'Mas Vistas',
                style: TextStyle(fontWeight: FontWeight.w900),
              ),
            ),
          ],
        ),
      ),
      body: tabSelected,
    );
  }
}
