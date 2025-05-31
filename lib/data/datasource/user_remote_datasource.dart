import '../models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<UserModel> getUserProfile();
}

class MockUserRemoteDataSourceImpl implements UserRemoteDataSource {
  @override
  Future<UserModel> getUserProfile() async {
    // Simulate API delay
    await Future.delayed(Duration(milliseconds: 500));
    return UserModel(
      name: "Albert Florest",
      role: "Buyer",
      profileImageUrl: "https://i.pravatar.cc/300",
    );
  }
}
