import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:productreward/core/network/api_service.dart';

import '../../data/models/LoginResponse.dart';
import '../../data/models/reward_model.dart';
import 'UserProvider.dart';

class RewardsListProvider extends ChangeNotifier {
  bool isLoading = true;
  List<Reward> rewards = [];
  String? errorMessage;
  final api = ApiService();

  Future<void> fetchRewards() async {
    isLoading = true;
    notifyListeners();
    final response = await api.getRewardList();
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      if (jsonResponse['status'] == true) {
        final List<dynamic> data = jsonResponse['data'];
        rewards = data.map((e) => Reward.fromJson(e)).toList();
      } else {
        errorMessage = jsonResponse['message'] ?? 'Unknown error';
      }
    } else {
      errorMessage = 'Server error: ${response.statusCode}';
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> fetchPoints(String userID, UserProvider userProvider, String from) async {
    final response = await api.getPoints(userID);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if(data['status'] == true) {
        final loginResponse = LoginResponse.fromJson(data);
        if (loginResponse.status) {
          final userData = loginResponse.data;
          userProvider.setUserData(userData);
          debugPrint("fetchpoints $from");
        }
      }
    }

  }

  Future<Map<String, dynamic>> redeemReward(String rewardId, String userId, UserProvider userProvider,) async {
    try {
      final response = await api.redeemRewards(rewardId, userId);

      if (response.statusCode == 200) {
        // You can handle success message or update local state here
        final jsonResponse = jsonDecode(response.body);
        if(jsonResponse['status'] == true) {
          // final userJson = jsonResponse['data'];
          // final userData = UserData.fromJson(userJson);
          // userProvider.setUserData(userData);
          // debugPrint("saveuserdata ${userData.email}");
          // await fetchPoints(userId, userProvider);
          return {
            'success': true,
            'message': jsonResponse['message'] ?? 'Redeem successful',
          };
        } else {
          return {
            'success': false,
            'message': jsonResponse['message'] ?? 'Redeem Unsuccessful',
          };
        }
      } else {
        return {
          'success': false,
          'message': 'Redeem failed',
        };
      }
    }catch(e) {
      return {
        'success': false,
        'message': 'Error during redeem: $e',
      };
    }
  }

}
