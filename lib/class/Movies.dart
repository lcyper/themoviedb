import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:themoviedb/helpers/bordered_text.dart';

// 'https://api.themoviedb.org/3/movie/550?api_key=0e685fd77fb3d76874a3ac26e0db8a4b';
const String baseUrl = 'https://api.themoviedb.org/3/movie/';
const String apiKey = '0e685fd77fb3d76874a3ac26e0db8a4b';
// https://api.themoviedb.org/3/movie/popular?api_key=0e685fd77fb3d76874a3ac26e0db8a4b&language=es

class Movies {
  final String title;
  final String description;
  final List gender;
  final String picture;
  final String voteAverage;

  Movies(
      {this.title,
      this.description,
      this.gender,
      this.picture,
      this.voteAverage});

  factory Movies.fromJson(Map json) {
    String title = json['title'] ?? json['original_title'];
    String description = json['overview'];
    List gender = json['genre_ids'];
    String picture = 'https://www.themoviedb.org/t/p/w600_and_h900_bestv2' +
        json['poster_path'];
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
  Future<Widget> getMovies({int page = 1, String url = 'popular'}) async {
    Map data = await makeRequest(page: 1, url: 'popular');
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

Widget createCard(Movies movie) {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(8.0),
      ),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ListTile(
          leading: SizedBox(
            child: Image.network(
              movie.picture,
              // width: double.infinity,
            ),
            width: 100.0,
          ),
          title: Row(
            children: [
              Text(
                movie.title,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              Spacer(),
              BorderedText(
                strokeWidth: 3.0,
                strokeColor: Colors.black,
                child: Text(
                  movie.voteAverage,
                  style: TextStyle(
                    color: Colors.yellow,
                  ),
                ),
              ),
              // (
              //   movie.voteAverage,
              //   // textAlign: TextAlign.end,
              //   style: TextStyle(
              //     color: Colors.yellow,
              //     decorationThickness: 3.0,
              //     decorationColor: Colors.black,
              //     decorationStyle: TextDecorationStyle.wavy,
              //   ),),
            ],
          ),
          // subtitle: Text(movie.description),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: movie.gender
              .map((gender) => SizedBox(
                    child: Text(gender.toString()),
                    width: 50.0,
                  ))
              .toList(),
        ),
      ],
    ),
  );
}
