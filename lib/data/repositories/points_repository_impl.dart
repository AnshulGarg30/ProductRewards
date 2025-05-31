import '../../domain/entities/points_entity.dart';
import '../../domain/repositories/points_repository.dart';
import '../datasource/points_remote_datasource.dart';

class PointsRepositoryImpl implements PointsRepository {
  final PointsRemoteDataSource dataSource;

  PointsRepositoryImpl(this.dataSource);

  @override
  Future<Points> fetchPoints() => dataSource.fetchPoints();
}
