import 'package:flutter/material.dart';

import '../../data/datasource/auth_local_datasource.dart';
import '../../data/models/LoginResponse.dart';

class UserProvider extends ChangeNotifier {
  final AuthLocalDataSource _authLocalDataSource = AuthLocalDataSource();

  UserData? _userData;
  UserData? get userData => _userData;

  Future<void> loadUserData() async {
    _userData = await _authLocalDataSource.getUserData();
    notifyListeners();
  }

  void setUserData(UserData user) {
    _userData = user;
    _authLocalDataSource.saveUserData(user); // Optionally persist it
    notifyListeners();
  }

  void clearUser() {
    _userData = null;
    _authLocalDataSource.clearLoginStatus(); // Clear from local storage too
    notifyListeners();
  }
}
