abstract class LoginAuthRepository {
  Future<bool> isLoggedIn();
  Future<void> setLoggedIn(bool value);
}
