import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

// 'https://api.themoviedb.org/3/movie/550?api_key=0e685fd77fb3d76874a3ac26e0db8a4b';
const String baseUrl = 'https://api.themoviedb.org/3/movie/';
const String apiKey = '0e685fd77fb3d76874a3ac26e0db8a4b';
// https://api.themoviedb.org/3/movie/popular?api_key=0e685fd77fb3d76874a3ac26e0db8a4b&language=es

class Movies {
  final String title;
  final String description;
  final String gender;
  final String picture;

  Movies({this.title, this.description, this.gender, this.picture});

  // Factory Movies.fromJson(Map<String, dynamic> json){
  // ....
  // Movies(title, description, gender, picture);
  // }

  Future<Map<String, dynamic>> popular({int page = 1}) async {
    try {
      var response = await Dio().get(
        '${baseUrl}popular',
        queryParameters: {
          'api_key': apiKey,
          'language': 'es',
          'page': page,
        },
      );
      if (response.statusMessage == 'OK') {
        print(response.data);
        return response.data;
      }
      return {'statusMessage': 'error'};
    } catch (e) {
      return (e);
    }
  }
}
