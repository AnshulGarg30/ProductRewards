import '../entities/points_entity.dart';
import '../repositories/points_repository.dart';

class GetPointsUseCase {
  final PointsRepository repository;

  GetPointsUseCase(this.repository);

  Future<Points> call() => repository.fetchPoints();
}
