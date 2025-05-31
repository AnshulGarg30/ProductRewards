import 'package:productreward/domain/entities/points_entity.dart';

class RewardRecentActivityListModel extends RewardList {
  RewardRecentActivityListModel({
    required String id,
    required String merchantName,
    required String description,
    required int points,
    required DateTime date,
  }) : super(
    id: id,
    merchantName: merchantName,
    description: description,
    points: points,
    date: date,
  );

  factory RewardRecentActivityListModel.fromJson(Map<String, dynamic> json) {
    return RewardRecentActivityListModel(
      id: json['id'],
      merchantName: json['merchantName'],
      description: json['description'],
      points: json['points'],
      date: DateTime.parse(json['date']),
    );
  }
}
