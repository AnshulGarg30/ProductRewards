class RedeemRequestItem {
  final int id;
  final int userId;
  final int rewardId;
  final String point;
  final int status;
  final String createdAt;
  final String updatedAt;
  final Reward? reward;

  RedeemRequestItem({
    required this.id,
    required this.userId,
    required this.rewardId,
    required this.point,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.reward,
  });

  factory RedeemRequestItem.fromJson(Map<String, dynamic> json) {
    return RedeemRequestItem(
      id: json['id'],
      userId: json['user_id'],
      rewardId: json['reward_id'],
      point: json['point'],
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      reward: json['reward'] != null ? Reward.fromJson(json['reward']) : null,
    );
  }
}

class Reward {
  final int id;
  final String name;
  final String image;
  final int status;
  final String createdAt;
  final String updatedAt;
  final String point;

  Reward({
    required this.id,
    required this.name,
    required this.image,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.point,
  });

  factory Reward.fromJson(Map<String, dynamic> json) {
    return Reward(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      point: json['point'],
    );
  }
}
