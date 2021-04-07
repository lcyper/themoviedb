 import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences _preferences;
  Future<SharedPreferences> get preferences async {
    if (_preferences == null) {
      _preferences = await SharedPreferences.getInstance();
    }
    return _preferences;
  }