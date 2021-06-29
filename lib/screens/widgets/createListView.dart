import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:themoviedb/provider/cacheApp.dart';

import 'package:themoviedb/class/Movies.dart';
import 'package:themoviedb/screens/widgets/createCard.dart';

Widget createListView(List<Movies> movies, {String type}) {
  if (movies.length == 0 || movies[0].title == null) {
    return Center(child: Text('Ups! vacio.'));
  }
  return ListView.builder(
    padding: const EdgeInsets.all(8),
    itemCount: movies.length,
    itemBuilder: (context, index) {
      if (type == "favorite") {
        //es caso de que sea en la pagina de favoritos
        return _dismissible(index, movies, context);
      }
      return CreateCard(movie: movies[index]);
    },
  );
}

Dismissible _dismissible(int index, List<Movies> movies, BuildContext context) => Dismissible(
        key: Key(index.toString()),
        child: CreateCard(movie: movies[index]),
        background: Container(
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(right: 15.0, top: 20.0),
          child: Icon(
            Icons.delete,
            color: Colors.red,
            size: 30.0,
          ),
        ),
        direction: DismissDirection.endToStart,
        onDismissed: (direction) {
          if (direction == DismissDirection.endToStart) {
            Provider.of<CacheApp>(context, listen: false).toggleFavorite =
                movies[index];
            // Movies().toggleFavorite(id: movies[index].id);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content:
                    Text(movies[index].title + ' eliminada de Favoritos'),
                duration: Duration(seconds: 2),
              ),
            );
            return movies.removeAt(index);
          }
        },
      );