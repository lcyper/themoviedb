import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:themoviedb/helpers/shared_preferences.dart';
import 'package:themoviedb/screens/widgets/createCard.dart';

// 'https://api.themoviedb.org/3/movie/550?api_key=0e685fd77fb3d76874a3ac26e0db8a4b';
const String baseUrl = 'https://api.themoviedb.org/3/movie/';
const String apiKey = '0e685fd77fb3d76874a3ac26e0db8a4b';
// https://api.themoviedb.org/3/movie/popular?api_key=0e685fd77fb3d76874a3ac26e0db8a4b&language=es
const String baseUrlImage =
    'https://www.themoviedb.org/t/p/w600_and_h900_bestv2';

final Map cacheDataApi = {}; //aca se almacena el cache de peliculas

class Movies {
  final String title;
  final String description;
  final List gender;
  final String picture;
  final String voteAverage;

  Movies({
    this.title,
    this.description,
    this.gender,
    this.picture,
    this.voteAverage,
  });

  // _pref()async => await SharedPreferences preferences;

  factory Movies.fromJson(Map json) {
    String title = json['title'] ?? json['original_title'];
    String description = json['overview'];
    List gender = json['genre_ids'];
    String picture = baseUrlImage + json['poster_path'];
    String voteAverage = json['vote_average'].toString();
    return Movies(
      title: title,
      description: description,
      gender: gender,
      picture: picture,
      voteAverage: voteAverage,
    );
  }

  // clase de llamada principal, maneja todo.
  Future<Widget> getMovies({int page = 1, String url}) async {
    Map data;
    if (cacheDataApi[url] == null) {
      data = await makeRequest(page: page, url: url);
      cacheDataApi[url] = data;
    } else {
      data = cacheDataApi[url];
    }
    return createListView(data);
  }
}

/////////////////////////////////////////
// Funciones de ayuda para esta clase //
///////////////////////////////////////
Future<Map<String, dynamic>> makeRequest(
    {int page = 1, String url = 'popular'}) async {
  // implementar el cache de la peticion

  try {
    var response = await Dio().get(
      baseUrl + url,
      queryParameters: {
        'api_key': apiKey,
        'language': 'es',
        'page': page,
      },
    );
    if (response.statusMessage == 'OK') {
      // _cache = response.data;
      return response.data;
    } else {
      return {'statusMessage': response.statusMessage};
    }
  } catch (e) {
    return (e);
  }
}

Widget createListView(Map data) {
  List list =
      data['results'].map((element) => Movies.fromJson(element)).toList();

  return ListView.builder(
    padding: const EdgeInsets.all(8),
    itemCount: list.length,
    itemBuilder: (context, index) => createCard(list[index]),
  );
}
