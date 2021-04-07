import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:themoviedb/helpers/bordered_text.dart';
import 'package:themoviedb/helpers/shared_preferences.dart';

// 'https://api.themoviedb.org/3/movie/550?api_key=0e685fd77fb3d76874a3ac26e0db8a4b';
const String baseUrl = 'https://api.themoviedb.org/3/movie/';
const String apiKey = '0e685fd77fb3d76874a3ac26e0db8a4b';
// https://api.themoviedb.org/3/movie/popular?api_key=0e685fd77fb3d76874a3ac26e0db8a4b&language=es
const String baseUrlImage =
    'https://www.themoviedb.org/t/p/w600_and_h900_bestv2';

final Map dataApi = {}; //aca se almacena el cache de peliculas

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
  Future<Widget> getMovies({int page = 1, String url = 'popular'}) async {
    Map data;
    if (dataApi[url] == null) {
      data = await makeRequest(page: page, url: url);
      dataApi[url] = data;
    } else {
      data = dataApi[url];
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

Widget createCard(Movies movie) {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(8.0),
      ),
    ),
    // color: Colors.yellowAccent,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      // mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.network(
          movie.picture,
          alignment: Alignment.topLeft,
          width: 80.0,
          cacheHeight: 100,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  movie.title,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: Colors.black,
                  ),
                ),
                // Spacer(),
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
              ],
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.start,
            //   crossAxisAlignment: CrossAxisAlignment.end,
            //   children: movie.gender
            //       .map((gender) => SizedBox(
            //             child: Text(gender.toString()),
            //             width: 50.0,
            //           ))
            //       .toList(),
            // ),
          ],
        ),
        // subtitle: Text(movie.description),
      ],
    ),
  );
}
