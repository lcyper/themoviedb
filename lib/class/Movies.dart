import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:themoviedb/helpers/helpers.dart';
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
  });

  // _pref()async => await SharedPreferences preferences;

  factory Movies.fromJson(Map json) {
    String title = json['title'] ?? json['original_title'];
    String description = json['overview'];
    List<String> gender = setGenres(json['genre_ids']);
    String posterPath =
        json['poster_path'] != null ? baseUrlImage + json['poster_path'] : null;
    String backdropPath = json['backdrop_path'] != null
        ? baseUrlImage + json['backdrop_path']
        : null;
    String voteAverage = json['vote_average'].toString();
    String id = json['id'].toString();
    bool adult = json['adult'];
    DateTime releaseDate = DateTime.parse(json['release_date']);

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
  Future<Widget> getMovies({int page = 1, String url, String id}) async {
    // tengo q continuar con el tema de mostrar la peli x ID
    if (id != null) {
      return getMoviesInfo(id);
    }
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

    if (cacheDataApi[url] == null) {
      data = await makeRequest(page: page, url: url);
      cacheDataApi[url] = data;
    } else {
      data = cacheDataApi[url];
    }
    return createListView(data);
  }

  Future<Widget> lookByQuerry(String inputValue) async {
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
    return createListView(data);
  }

  Widget getMoviesInfo(String id) {
    return Center(
      child: ListView(
        children: [
          Text(this.title),
          Image.network(
            this.posterPath,
          ),
        ],
      ),
    );
  }

  String getGender(List<String> listGender) {
    String genderNames = "";
    for (var gender in listGender) {
      if (gender == listGender.last) {
        genderNames += " " + gender;
      } else {
        genderNames += " " + gender + ' /';
      }
    }
    return genderNames;
  }
}

/////////////////////////////////////////
// Funciones de ayuda para esta clase //
///////////////////////////////////////
Future<Map<String, dynamic>> makeRequest(
    {int page = 1, String url, String language = 'es', String query}) async {
  // implementar el cache de la peticion

  try {
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

Widget createListView(Map data) {
  if (data['results'].length == 0) {
    return Text('No hemos encontrado lo que buscaste.');
  }
  List list =
      data['results'].map((element) => Movies.fromJson(element)).toList();

  return ListView.builder(
    // scrollDirection: Axis.vertical,
    // shrinkWrap: true,
    padding: const EdgeInsets.all(8),
    itemCount: list.length,
    itemBuilder: (context, index) => CreateCard(movie: list[index]),
  );
}

List setGenres(List genresList) {
  List<String> genresListByName = List<String>.from(genresList.map((id) {
    return cacheDataApi['genres'][id];
  }));
  // .toList();

  return genresListByName; // ['Accion', 'Drama'];
}
