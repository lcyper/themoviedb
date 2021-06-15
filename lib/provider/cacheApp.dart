import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheApp with ChangeNotifier {
  Map _cacheDataApi;

  CacheApp() {
    setup();
  }
  void setup() async {
    final SharedPreferences _preferences =
        await SharedPreferences.getInstance();
    // if (cacheDataApi.length == 1) {
    var cacheDataString = _preferences.getString('cacheDataApi');
    if (cacheDataString != null) {
      // cacheDataApi = json.decode(cacheDataString);
      _cacheDataApi = json.decode(cacheDataString);
    }
    // }
    // notifyListeners();
  }

  Map get cacheDataApi => _cacheDataApi;

  set cacheDataApi(Map cacheDataApi) {
    _cacheDataApi = cacheDataApi;
    notifyListeners();
  }
}
