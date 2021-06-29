import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:themoviedb/class/Movies.dart';

class CacheApp with ChangeNotifier {
  SharedPreferences _preferences;
  Map _cacheDataApi = {};
  // var _toggleFavorite;

  CacheApp() {
    setup();
  }

  get getMovies => null;

  void setup() async {
    _preferences = await SharedPreferences.getInstance();

    //en caso de no tener internet
    var cacheDataString = _preferences.getString('cacheDataApi');
    if (cacheDataString != null) {
      _cacheDataApi = json.decode(cacheDataString);
    }
    if (_cacheDataApi['genres'] == null) {
      _cacheDataApi['genres'] = await Movies().getGenresList();
    }
    notifyListeners();
  }

  Map get cacheDataApi => _cacheDataApi;

  set cacheDataApi(Map cacheDataApi) {
    _cacheDataApi = cacheDataApi;
    _preferences.setString('cacheDataApi', json.encode(cacheDataApi));
    // json.encode(_cacheDataApi);
    notifyListeners();
  }

  List<Movies> get favoriteMovies {
    // return Movies().getFavoriteMovies;
    Map favorites = _cacheDataApi['favorite'];
    List<Movies> movies = [];
    if (favorites != null) {
      favorites.forEach((key, value) {
        Movies movie = Movies.fromJson(value, _cacheDataApi);
        movies.add(movie);
      });
    } else {
      _cacheDataApi['favorite'] = {};
    }
    return movies;
  }

  set toggleFavorite(Movies movie) {
    movie.favorite = !movie.favorite;

    if (!_cacheDataApi['favorite'].containsKey(movie.id)) {
      //{movie.id: this}
      // _cacheDataApi['favorite'].addAll({movie.id: this});
      _cacheDataApi['favorite']
          .addAll({movie.id: Movies().toJSONEncodable(movie)});
    } else {
      _cacheDataApi['favorite'].remove(movie.id);
    }

    print('favoritos.lenght: ' + _cacheDataApi['favorite'].length.toString());

    // await _preferences.setString('cacheDataApi', json.encode(cacheDataApi));
    cacheDataApi = _cacheDataApi;
  }
}
