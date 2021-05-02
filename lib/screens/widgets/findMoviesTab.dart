import 'dart:async';

import 'package:flutter/material.dart';
import 'package:themoviedb/class/Movies.dart';

class FindMoviesTab extends StatefulWidget {
  @override
  _FindMoviesTabState createState() => _FindMoviesTabState();
}

class _FindMoviesTabState extends State<FindMoviesTab> {
  String _inputValue;
  Future<List<Movies>> _movieList;
  final TextEditingController _controler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(13.0),
      child: Column(
        children: [
          Text('Te gustaria buscar una peli?'),
          Form(
            child: TextFormField(
              controller: _controler,
              onEditingComplete: () {
                FocusScope.of(context).unfocus();
                setState(() {
                  _movieList = Movies().lookByQuerry(_inputValue);
                });
                print(_inputValue);
              },
              onChanged: (value) {
                _inputValue = value;
              },
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'Nombre de la peli?',
                suffixIcon: IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      _controler.clear();
                    }),
              ),
            ),
          ),
          FutureBuilder(
            future: _movieList,
            builder: (context, snapshot) => snapshot.hasData
                ? snapshot.hasError
                    ? Center(
                        child: Text('Error.'),
                      )
                    : Expanded(
                        child: createListView(snapshot.data),
                      )
                : Text('las peliculas apareceran aca.'),
          ),
        ],
      ),
    );
  }
}
