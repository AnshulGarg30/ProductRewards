import '../models/points_model.dart';

abstract class PointsRemoteDataSource {
  Future<PointsModel> fetchPoints();
}

class MockPointsRemoteDataSource implements PointsRemoteDataSource {
  @override
  Future<PointsModel> fetchPoints() async {
    await Future.delayed(Duration(milliseconds: 500));
    return PointsModel(
      withdrawal: 1500,
      remaining: 3600,
      pending: 7000,
      total: 150,
    );
  }
}
