import '../models/reward_model.dart';

abstract class RewardListDataSource {
  Future<List<RewardRecentActivityListModel>> getReward();
}

class MockRewardRecentListDataSource implements RewardListDataSource {
  @override
  Future<List<RewardRecentActivityListModel>> getReward() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      RewardRecentActivityListModel(
        id: '1',
        merchantName: 'Uber',
        description: '\$45.00 at Uber',
        points: 56,
        date: DateTime.now().subtract(Duration(days: 1)),
      ),
      RewardRecentActivityListModel(
        id: '2',
        merchantName: 'Starbucks',
        description: '\$15.00 at Starbucks',
        points: 123,
        date: DateTime.now().subtract(Duration(days: 2)),
      ),
    ];
  }
}
