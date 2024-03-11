import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Authprovider extends ChangeNotifier {
  String? _userID;
  String? _name;
  String? _email;
  String? _image;

  String? get userID => _userID;
  String? get name => _name;
  String? get email => _email;
  String? get image => _image;

  // Key for storing user ID in SharedPreferences
  static const String _userIDKey = 'userID';

  static const String _userNameKey = 'userName';
  static const String _userEmailKey = 'userEmail';

  // Initialize Authprovider and load user ID from SharedPreferences
  Authprovider() {
    _loadUserID();
    _loadUserDetails();
  }

  // Load user ID from SharedPreferences
  Future<void> _loadUserID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _userID = prefs.getString(_userIDKey);
    notifyListeners();
  }

   Future<void> _loadUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _name = prefs.getString(_userNameKey);
    _email = prefs.getString(_userEmailKey);
    notifyListeners();
  }


  // Store user ID in SharedPreferences and notify listeners
  Future<void> _saveUserID(String? userID) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userIDKey, userID ?? '');
    _userID = userID;
    notifyListeners();
  }

  void setUserID(String? userID) {
    _saveUserID(userID); // Save user ID in SharedPreferences
  }
  // Store user details in SharedPreferences and notify listeners
  Future<void> _saveUserDetails({String? name, String? email}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userNameKey, name ?? '');
    await prefs.setString(_userEmailKey, email ?? '');
    _name = name;
    _email = email;
    notifyListeners();
  }

  

  void setUserdetails({String? email, String? name, String? image}) {
    _saveUserDetails(name: name, email: email); // Save user details in SharedPreferences
    notifyListeners();
  }

  notifyListeners();
}
