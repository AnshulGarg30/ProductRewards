import '../repositories/login_auth_repository.dart';

class CheckLoginStatus {
  final LoginAuthRepository repository;
  CheckLoginStatus(this.repository);

  Future<bool> call() => repository.isLoggedIn();
}