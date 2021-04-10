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
    return Column(
      children: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                flex: 5,
                child: OutlinedButton(
                  // focusNode: FocusNode(onKey: ),
                  // autofocus: true,
                  // key: Key('Populares'),
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Colors.yellow,
                        width: 4.0,
                        style: BorderStyle.solid,
                      ),
                    ),
                    // backgroundColor: Colors.blue,
                  ),
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
              ),
              Expanded(
                flex: 5,
                child: OutlinedButton(
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
              ),
            ],
          ),
          flex: 1,
        ),
        Expanded(
          child: tabSelected,
          flex: 9,
        ),
      ],
    );
  }

  TextStyle _textStyleLabels = TextStyle(
    fontWeight: FontWeight.w900,
    color: Colors.black,
    fontStyle: FontStyle.italic,
    fontSize: 20.0,
  );
}
