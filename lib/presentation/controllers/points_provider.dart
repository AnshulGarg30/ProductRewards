import 'package:flutter/material.dart';
import '../../domain/entities/points_entity.dart';
import '../../domain/usecases/get_points_usecase.dart';

class PointsProvider extends ChangeNotifier {
  final GetPointsUseCase getPoints;

  Points? points;
  bool isLoading = true;

  PointsProvider(this.getPoints) {
    loadPoints();
  }

  Future<void> loadPoints() async {
    isLoading = true;
    notifyListeners();

    points = await getPoints();
    isLoading = false;
    notifyListeners();
  }
}
