import 'package:flutter/cupertino.dart';
import 'package:productreward/domain/entities/points_entity.dart';

import '../../domain/usecases/get_rewards_usecase.dart';

class RewardsListProvider extends ChangeNotifier {
  final GetRewardsListUseCase useCase;
  List<RewardList> rewards = [];
  bool isLoading = true;

  RewardsListProvider(this.useCase) {
    loadRewards();
  }

  Future<void> loadRewards() async {
    isLoading = true;
    notifyListeners();
    rewards = await useCase();
    isLoading = false;
    notifyListeners();
  }
}
