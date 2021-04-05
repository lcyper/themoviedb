import 'package:flutter/material.dart';

class FindMoviesTab extends StatefulWidget {
  @override
  _FindMoviesTabState createState() => _FindMoviesTabState();
}

class _FindMoviesTabState extends State<FindMoviesTab> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(13.0),
      child: Column(
        children: [
          Text('Te gustaria buscar una peli?'),
          Form(
            child: TextFormField(
              decoration: InputDecoration(
                hintText: 'Nombre de la peli?',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
