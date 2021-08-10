import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:themoviedb/class/Movies.dart';
import 'package:themoviedb/helpers/is_internet.dart';

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
    String cacheDataString = _preferences.getString('cacheDataApi');
    _cacheDataApi = json.decode(cacheDataString ?? "{}");
    _cacheDataApi['favorite'] ??= {};
    if (await isInternet()) {
      print('con internet');
      _cacheDataApi = _cacheDataApi.map((key, value) {
        if (key == 'favorite') {
          return MapEntry(key, value);
        }
        return MapEntry("","");
      });
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
    notifyListeners();
  }

  List<Movies> get favoriteMovies {
    Map favorites = _cacheDataApi['favorite'];
    List<Movies> movies = [];
    if (favorites != null) {
      favorites.forEach((key, value) {
        Movies movie = Movies.fromJson(value, _cacheDataApi);
        movies.add(movie);
      });
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
