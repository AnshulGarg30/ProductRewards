import 'package:productreward/domain/repositories/login_auth_repository.dart';

import '../datasource/auth_local_datasource.dart';

class AuthLoginRepositoryImpl implements LoginAuthRepository {
  final AuthLocalDataSource localDataSource;

  AuthLoginRepositoryImpl(this.localDataSource);

  @override
  Future<bool> isLoggedIn() => localDataSource.isLoggedIn();

  @override
  Future<void> setLoggedIn(bool value) => localDataSource.setLoggedIn(value);

}
