import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManager {
  static const String? _tokenKey = 'token';
  static const String? _userID = '1';

  static Future<void> setToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey!, token);
  }

  static Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey!);
  }

  static Future<void> setUserID(String id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userID!, id);
  }

  static Future<String?> getUserID() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey!);
  }
}
