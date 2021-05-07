import 'package:flutter/material.dart';
import 'package:themoviedb/class/Movies.dart';

class FindMoviesTab extends StatefulWidget {
  @override
  _FindMoviesTabState createState() => _FindMoviesTabState();
}

class _FindMoviesTabState extends State<FindMoviesTab> {
  Future<List<Movies>> _movieList;
  final TextEditingController _controler = TextEditingController();
  List<Widget> _noDataYet = [
    Text('las peliculas apareceran aca.'),
    Center(
      child: CircularProgressIndicator(),
    ),
  ];
  int _indexNoDataYet = 0;

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
                if (_controler.text.length > 1) {
                  setState(() {
                    _indexNoDataYet = 1;
                    _movieList = Movies().lookByQuerry(_controler.text);
                  });
                }
              },
              onChanged: (value) {
                // para evitar llamar a setState cada vez, solo cuando es necesario
                if (value.length == 0 || value.length == 1) {
                  setState(() {});
                }
              },
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'Nombre de la peli?',
                suffixIcon: _controler.text.length > 0
                    ? IconButton(
                        icon: Icon(
                          Icons.clear,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          setState(() {
                            _controler.clear();
                          });
                        })
                    : null,
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
                : _noDataYet[_indexNoDataYet],
          ),
        ],
      ),
    );
  }
}
