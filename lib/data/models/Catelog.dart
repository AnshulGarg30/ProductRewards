class Catelog {
  final int id;
  final String name;
  final String imageUrl;
  final int status;
  final String createdAt;
  final String updatedAt;
  final String point;
  final String pdf;

  Catelog({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this. point,
    required this.pdf
  });

  factory Catelog.fromJson(Map<String, dynamic> json) {
    return Catelog(
      id: json['id'] ?? 0,
      name: json['title'] ?? '',
      imageUrl: json['image'] ?? '',
      status: json['status'] ?? 0,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      point: json['point']?.toString() ?? '0',
      pdf: json['pdf'] ?? '',
    );
  }
}
