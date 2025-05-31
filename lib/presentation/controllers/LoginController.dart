import 'package:flutter/material.dart';
import '../../data/datasource/auth_local_datasource.dart';
import '../../domain/repositories/login_auth_repository.dart';
import '../../domain/usecases/check_login_status.dart';
import '../../domain/usecases/set_login_status.dart';

class LoginController extends ChangeNotifier {

  final CheckLoginStatus checkLoginStatus;
  final SetLoginStatus setLoginStatus;


  bool _isLoading = false;
  String? _error;

  bool get isLoading => _isLoading;
  String? get error => _error;

  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  LoginController({
    required this.checkLoginStatus,
    required this.setLoginStatus,
  });

  Future<void> init() async {
    _isLoggedIn = await checkLoginStatus();
    notifyListeners();
  }

  Future<void> login() async {
    await setLoginStatus(true);
    _isLoggedIn = true;
    notifyListeners();
  }

  Future<void> logout() async {
    await setLoginStatus(false);
    _isLoggedIn = false;
    notifyListeners();
  }

}
