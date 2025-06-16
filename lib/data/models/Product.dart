class Product {
  final int id;
  final String name;
  final String imageUrl;
  final int status;
  final String createdAt;
  final String updatedAt;
  final String point;

  Product({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this. point,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int,
      name: json['name'] as String,
      imageUrl: json['image'] as String,
      status: json['status'] as int,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
        point: json['point'] as String
    );
  }
}
