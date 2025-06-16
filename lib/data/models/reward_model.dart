class Reward {
  final int id;
  final String name;
  final String image;
  final int status;
  final String createdAt;
  final String updatedAt;
  final int point;

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
      point: int.parse(json['point']),
    );
  }
}
