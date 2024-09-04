import 'package:shared_preferences/shared_preferences.dart';

class PrefService {
  Future createCache(String email, String password) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("email", email);
    preferences.setString("password", password);
  }

  Future readCache(String email) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var cache = preferences.getString("email");
    return cache;
  }

  Future removeCache(String email, String password) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove("email");
    preferences.remove("password");
  }
}
