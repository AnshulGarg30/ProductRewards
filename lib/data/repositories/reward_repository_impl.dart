import 'package:productreward/data/datasource/mock_reward_datasource.dart';
import 'package:productreward/domain/entities/points_entity.dart';

import '../../domain/repositories/RewardsListRepository.dart';

class RewardListRepositoryImpl implements RewardListRepository {
  final RewardListDataSource dataSource;

  RewardListRepositoryImpl(this.dataSource);

  @override
  Future<List<RewardList>> getRewards() => dataSource.getReward();
}
