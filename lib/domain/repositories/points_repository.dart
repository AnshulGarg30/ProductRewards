import '../entities/points_entity.dart';

abstract class PointsRepository {
  Future<Points> fetchPoints();
}
