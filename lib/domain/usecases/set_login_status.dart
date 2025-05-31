
import '../repositories/login_auth_repository.dart';

class SetLoginStatus {
  final LoginAuthRepository repository;
  SetLoginStatus(this.repository);

  Future<void> call(bool value) => repository.setLoggedIn(value);
}
