import 'package:productreward/domain/entities/points_entity.dart';

abstract class RewardListRepository {
  Future<List<RewardList>> getRewards();
}
