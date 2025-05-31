import '../../domain/entities/user.dart';

class UserModel extends User {
  UserModel({required String name, required String role, required String profileImageUrl})
      : super(name: name, role: role, profileImageUrl: profileImageUrl);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      role: json['role'],
      profileImageUrl: json['profileImageUrl'],
    );
  }
}
