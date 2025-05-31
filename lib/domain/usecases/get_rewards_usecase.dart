import 'package:productreward/domain/entities/points_entity.dart';
import 'package:productreward/domain/repositories/RewardsListRepository.dart';

class GetRewardsListUseCase {
  final RewardListRepository repository;

  GetRewardsListUseCase(this.repository);

  Future<List<RewardList>> call() => repository.getRewards();
}
