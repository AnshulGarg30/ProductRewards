import 'package:flutter/material.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/get_user_profile.dart';

class ProfileProvider extends ChangeNotifier {
  final GetUserProfile getUserProfile;

  User? user;
  bool isLoading = true;

  ProfileProvider(this.getUserProfile) {
    loadProfile();
  }

  Future<void> loadProfile() async {
    isLoading = true;
    notifyListeners();

    user = await getUserProfile();
    isLoading = false;
    notifyListeners();
  }
}
