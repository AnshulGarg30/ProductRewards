import 'package:productreward/data/models/UserData.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';


class AuthLocalDataSource {
  static const _loggedInKey = 'isLoggedIn';
  static const _userDataKey = 'userData';

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_loggedInKey) ?? false;
  }

  Future<void> setLoggedIn(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_loggedInKey, value);
  }

  // Clear the login status (logout)
  Future<void> clearLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_loggedInKey);
    await prefs.remove(_userDataKey);
  }

  Future<void> saveUserData(UserData user) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(user.toJson());
    await prefs.setString(_userDataKey, jsonString);
  }

  Future<UserData?> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_userDataKey);
    if (jsonString == null) return null;
    final jsonMap = jsonDecode(jsonString);
    return UserData.fromJson(jsonMap);
  }
}
