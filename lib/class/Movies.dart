import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:themoviedb/class/Actors.dart';
// import 'package:themoviedb/helpers/helpers.dart'; //handleError
import 'package:themoviedb/screens/widgets/createCard.dart';

// 'https://api.themoviedb.org/3/movie/550?api_key=0e685fd77fb3d76874a3ac26e0db8a4b';
const String baseUrl = 'https://api.themoviedb.org/3/';
const String apiKey = '0e685fd77fb3d76874a3ac26e0db8a4b';
// https://api.themoviedb.org/3/movie/popular?api_key=0e685fd77fb3d76874a3ac26e0db8a4b&language=es
// const String baseUrlImage =
//     'https://www.themoviedb.org/t/p/w600_and_h900_bestv2';
const String baseUrlImage = 'https://image.tmdb.org/t/p/w500';

const String imageAlternative =
    'https://www.themoviedb.org/assets/2/apple-touch-icon-cfba7699efe7a742de25c28e08c38525f19381d31087c69e89d6bcb8e3c0ddfa.png';

// Future<SharedPreferences> _preferences = (() async => await preferences())();
// final Map cacheDataApi = {};
Map cacheDataApi = {
  'favorite': Map<String, dynamic>.from({}),
}; //aca se almacena el cache de peliculas
//cambiar esto, hay q traer los datos con shared preferences y de inicio este inicializado
// cacheDataApi['favorite'] = [];

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
  bool favorite;
  String trailerId;

  Movies(
      {this.adult,
      this.title,
      this.description,
      this.gender,
      this.posterPath,
      this.backdropPath,
      this.voteAverage,
      this.id,
      this.releaseDate,
      this.actors,
      this.favorite,
      this.trailerId});

  factory Movies.fromJson(Map json) {
    //si reconstruye de json para favoritos
    if (json['favorite'] == true) {
      List<Actors> actors = [];
      if (json['actors'] != null && json['actors'].length > 0) {
        actors = List<Actors>.from(
            json['actors'].map((actor) => Actors.fromJson(actor)));
      }
      return Movies(
        title: json['title'],
        description: json['description'],
        gender: List<String>.from(json['gender']),
        posterPath: json['posterPath'],
        backdropPath: json['backdropPath'],
        voteAverage: json['voteAverage'],
        id: json['id'],
        adult: json['adult'],
        releaseDate: DateTime.parse(json['releaseDate']),
        favorite: json['favorite'],
        trailerId: json['trailerId'],
        actors: actors ?? json['actors'],
      );
    }

    String title = json['title'] ?? json['original_title'];
    String description = json['overview'];
    List<String> gender = _setGenres(json['genre_ids']);
    String posterPath = json['poster_path'] != null
        ? baseUrlImage + json['poster_path']
        : imageAlternative; //si no viene la imagen se usa una alternativa
    String backdropPath = json['backdrop_path'] != null
        ? baseUrlImage + json['backdrop_path']
        : imageAlternative;
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
      favorite: false,
    );
  }

  // clase de llamada principal, maneja todo.
  Future getMovies({int page = 1, String url, String id}) async {
    final SharedPreferences _preferences =
        await SharedPreferences.getInstance();
    if (cacheDataApi.length == 1) {
      var cacheDataString = _preferences.getString('cacheDataApi');
      if (cacheDataString != null) {
        cacheDataApi = json.decode(cacheDataString);
      }
    }

    // cuando se pide el detalle de una pelicula
    if (id != null) {
      if (this.actors == null && this.trailerId == null) {
        Map jsonActorsData = await makeRequest(url: 'movie/$id/credits');
        _setActors(jsonActorsData);

        Map jsonTrailerData = await makeRequest(url: 'movie/$id/videos');
        _setTrailer(jsonTrailerData);
      }
      _setFavorite(); //verifica y setea
      final SharedPreferences _preferences =
          await SharedPreferences.getInstance();
      await _preferences.setString('cacheDataApi', json.encode(cacheDataApi));
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
          key: (e) => e['id'].toString(), value: (e) => e['name']);
      cacheDataApi['genres'] = genresList;
    }

    if (cacheDataApi[url] == null) {
      data = await makeRequest(page: page, url: url);
      cacheDataApi[url] = data;
    } else {
      data = cacheDataApi[url];
    }

    await _preferences.setString('cacheDataApi', json.encode(cacheDataApi));

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
          key: (e) => e['id'].toString(), value: (e) => e['name']);
      cacheDataApi['genres'] = genresList;
    }

    data = await makeRequest(page: 1, url: 'search/movie', query: inputValue);
    if (data['hasError'] == true) {
      return [Movies()]; //x q?
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

  getCacheDataApi() {
    return cacheDataApi;
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

  void toggleFavorite() async {
    this.favorite = !favorite;
    if (!cacheDataApi['favorite'].containsKey(this.id)) {
      //{this.id: this}
      // cacheDataApi['favorite'].addAll({this.id: this});
      cacheDataApi['favorite'].addAll({this.id: _toJSONEncodable(this)});
    } else {
      cacheDataApi['favorite'].remove(this.id);
    }
    final SharedPreferences _preferences =
        await SharedPreferences.getInstance();
    await _preferences.setString('cacheDataApi', json.encode(cacheDataApi));
    print('favoritos.lenght: ' + cacheDataApi['favorite'].length.toString());
  }

  Map _toJSONEncodable(Movies movie) {
    Map<String, dynamic> map = {
      'title': movie.title,
      'description': movie.description,
      'gender': movie.gender,
      'posterPath': movie.posterPath,
      'backdropPath': movie.backdropPath,
      'voteAverage': movie.voteAverage,
      'id': movie.id,
      'adult': movie.adult,
      'releaseDate': movie.releaseDate.toString(),
      'favorite': movie.favorite,
      'trailerId': movie.trailerId,
      'actors': Actors().toJSONEncodable(movie.actors),
    };
    return map;
  }

  void _setFavorite() {
    this.favorite = cacheDataApi['favorite'].containsKey(this.id);
  }

  void _setTrailer(Map json) {
    if (json['results'].isNotEmpty && this.trailerId == null) {
      String trailerId;
      json['results'].map((element) {
        if (element['type'] == 'Trailer' && element['site'] == 'YouTube') {
          // print('Movie Id: ' + element['key']);
          return trailerId = element['key'];
        }
      }).toString();
      this.trailerId = trailerId;
    }
  }
}

/////////////////////////////////////////
// Funciones de ayuda para esta clase //
///////////////////////////////////////
Future<Map<String, dynamic>> makeRequest({
  int page = 1,
  @required String url,
  String language = 'es',
  String query,
}) async {
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
      print(response.requestOptions.path);
      return response.data;
    } else {
      return {'statusMessage': response.statusMessage};
    }
  } catch (e) {
    return {'message': e.message, 'hasError': true};
  }
}

Widget createListView(List<Movies> movies) {
  if (movies.length == 0 || movies[0].title == null) {
    return Center(child: Text('Ups! esta vacio.'));
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
      return cacheDataApi['genres'][id.toString()];
    }),
  );
  return genresListByName; // ['Accion', 'Drama'];
}
