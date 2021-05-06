import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:themoviedb/class/Actors.dart';
// import 'package:themoviedb/helpers/helpers.dart'; //handleError
import 'package:themoviedb/helpers/shared_preferences.dart';
import 'package:themoviedb/screens/widgets/createCard.dart';

// 'https://api.themoviedb.org/3/movie/550?api_key=0e685fd77fb3d76874a3ac26e0db8a4b';
const String baseUrl = 'https://api.themoviedb.org/3/';
const String apiKey = '0e685fd77fb3d76874a3ac26e0db8a4b';
// https://api.themoviedb.org/3/movie/popular?api_key=0e685fd77fb3d76874a3ac26e0db8a4b&language=es
const String baseUrlImage =
    'https://www.themoviedb.org/t/p/w600_and_h900_bestv2';

final Map cacheDataApi = {}; //aca se almacena el cache de peliculas

class Movies {
  final String title;
  final String description;
  final List<String> gender;
  final String posterPath;
  final String voteAverage;
  final String id;
  final String backdropPath;
  final bool adult;
  final DateTime releaseDate;
  List<Actors> actors;

  Movies({
    this.adult,
    this.title,
    this.description,
    this.gender,
    this.posterPath,
    this.backdropPath,
    this.voteAverage,
    this.id,
    this.releaseDate,
    this.actors,
  });

  // _pref()async => await SharedPreferences preferences;

  factory Movies.fromJson(Map json) {
    String title = json['title'] ?? json['original_title'];
    String description = json['overview'];
    List<String> gender = _setGenres(json['genre_ids']);
    String posterPath =
        json['poster_path'] != null ? baseUrlImage + json['poster_path'] : null;
    String backdropPath = json['backdrop_path'] != null
        ? baseUrlImage + json['backdrop_path']
        : null;
    String voteAverage = json['vote_average'].toString();
    String id = json['id'].toString();
    bool adult = json['adult'];
    DateTime releaseDate = json['release_date'] != null
        ? DateTime.parse(json['release_date'])
        : null;

    return Movies(
      title: title,
      description: description,
      gender: gender,
      posterPath: posterPath,
      backdropPath: backdropPath,
      voteAverage: voteAverage,
      id: id,
      adult: adult,
      releaseDate: releaseDate,
    );
  }

  // clase de llamada principal, maneja todo.
  Future getMovies({int page = 1, String url, String id}) async {
    // cuando se pide el detalle de una pelicula
    if (id != null) {
      Map json = await makeRequest(url: 'movie/$id/credits');
      _setActors(json);

      return this;
    }
    Map data;
    if (cacheDataApi['genres'] == null) {
      Map genresList = await makeRequest(url: 'genre/movie/list');
      if (genresList['hasError'] != null) {
        print('genresList Error: ' + genresList['hasError']);
        // return handleErrorWidget(genresList);
      }
      genresList = Map.fromIterable(genresList['genres'],
          key: (e) => e['id'], value: (e) => e['name']);
      cacheDataApi['genres'] = genresList;
    }

    if (cacheDataApi[url] == null) {
      data = await makeRequest(page: page, url: url);
      cacheDataApi[url] = data;
    } else {
      data = cacheDataApi[url];
    }
    List<Movies> list = List<Movies>.from(
        data['results'].map((element) => Movies.fromJson(element)));
    return list;
  }

  Future<List<Movies>> lookByQuerry(String inputValue) async {
    Map data;
    if (cacheDataApi['genres'] == null) {
      Map genresList = await makeRequest(url: 'genre/movie/list');
      // if (genresList['hasError']) {
      // return handleErrorWidget(genresList);
      // }
      genresList = Map.fromIterable(genresList['genres'],
          key: (e) => e['id'], value: (e) => e['name']);
      cacheDataApi['genres'] = genresList;
    }

    data = await makeRequest(page: 1, url: 'search/movie', query: inputValue);
    // cacheDataApi[url] = data;
    if (data['hasError'] == true) {
      return [Movies()];
    }
    List<Movies> list = List<Movies>.from(
        data['results'].map((element) => Movies.fromJson(element)));
    return list;
  }

  String getGender(List<String> listGender) {
    String genderNames = "";
    for (var gender in listGender) {
      if (gender == listGender.last) {
        genderNames += " " + gender;
      } else {
        genderNames += " " + gender + ' |';
      }
    }
    return genderNames;
  }

  getActors() {
    // this.actors;
  }

  void _setActors(Map json) {
    var list = json['cast'].map((actor) {
      actor['image'] = actor['profile_path'] != null
          ? baseUrlImage + actor['profile_path']
          : null;
      return Actors.fromJson(actor);
    });
    this.actors = List<Actors>.from(list);
  }
}


/////////////////////////////////////////
// Funciones de ayuda para esta clase //
///////////////////////////////////////
Future<Map<String, dynamic>> makeRequest(
    {int page = 1, String url, String language = 'es', String query}) async {
  // implementar el cache de la peticion

  try {
    // print('URL: ' + baseUrl + url);
    var response = await Dio().get(
      baseUrl + url,
      queryParameters: {
        'api_key': apiKey,
        'language': language,
        'page': page,
        'query': query,
      },
    );
    if (response.statusMessage == 'OK') {
      // _cache = response.data;
      return response.data;
    } else {
      return {'statusMessage': response.statusMessage};
    }
  } catch (e) {
    return {'message': e.message, 'hasError': true};
    // return (e);
  }
}

Widget createListView(List<Movies> movies) {
  if (movies[0].title == null) {
    return Text('No hemos encontrado lo que buscaste.');
  }
  return ListView.builder(
    // scrollDirection: Axis.vertical,
    // shrinkWrap: true,
    padding: const EdgeInsets.all(8),
    itemCount: movies.length,
    itemBuilder: (context, index) => CreateCard(movie: movies[index]),
  );
}

List _setGenres(List genresList) {
  List<String> genresListByName = List<String>.from(
    genresList.map((id) {
      return cacheDataApi['genres'][id];
    }),
  );
  return genresListByName; // ['Accion', 'Drama'];
}
