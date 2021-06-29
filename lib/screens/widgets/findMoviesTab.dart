import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:themoviedb/provider/cacheApp.dart';

import 'package:themoviedb/class/Movies.dart';
import 'package:themoviedb/screens/widgets/createListView.dart';

class FindMoviesTab extends StatefulWidget {
  @override
  _FindMoviesTabState createState() => _FindMoviesTabState();
}

class _FindMoviesTabState extends State<FindMoviesTab> {
  Future<List<Movies>> _movieList;
  final TextEditingController _controler = TextEditingController();
  List<Widget> _noDataYet = [
    Text('Las peliculas apareceran aca.'),
    CircularProgressIndicator(),
  ];
  int _indexNoDataYet = 0;

  @override
  Widget build(BuildContext context) {
    Map cacheDataApi = Provider.of<CacheApp>(context).cacheDataApi;
    return Padding(
      padding: const EdgeInsets.all(13.0),
      child: Column(
        children: [
          Form(
            child: TextFormField(
              cursorColor: Colors.yellow[900],
              controller: _controler,
              onEditingComplete: () {
                FocusScope.of(context).unfocus();
                if (_controler.text.length >= 1) {
                  setState(() {
                    _indexNoDataYet = 1;
                    _movieList = Movies().lookByQuerry(_controler.text, cacheDataApi);
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
                hintText: 'Nombre de la pelicula',
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.yellow[900], width: 3.0),
                ),
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
                : Expanded(child: Center(child: _noDataYet[_indexNoDataYet])),
          ),
        ],
      ),
    );
  }
}
