import '../../domain/entities/points_entity.dart';

class PointsModel extends Points {
  PointsModel({
    required int withdrawal,
    required int remaining,
    required int pending,
    required int total,
  }) : super(withdrawal: withdrawal, remaining: remaining, pending: pending, total: total);

  factory PointsModel.fromJson(Map<String, dynamic> json) {
    return PointsModel(
      withdrawal: json['withdrawal'],
      remaining: json['remaining'],
      pending: json['pending'],
      total: json['total'],
    );
  }
}
