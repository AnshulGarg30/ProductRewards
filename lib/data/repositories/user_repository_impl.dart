import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasource/user_remote_datasource.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl(this.remoteDataSource);

  @override
  Future<User> getUserProfile() async {
    return await remoteDataSource.getUserProfile();
  }
}
