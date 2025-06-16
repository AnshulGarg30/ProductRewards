class HistoryItem {
  final int id;
  final int userId;
  final String description;
  final String createdAt;
  final int? debit;
  final int? credit;
  final int total;

  HistoryItem({
    required this.id,
    required this.userId,
    required this.description,
    required this.createdAt,
    this.debit,
    this.credit,
    required this.total,
  });

  factory HistoryItem.fromJson(Map<String, dynamic> json) {
    return HistoryItem(
      id: json['id'],
      userId: json['user_id'],
      description: json['description'],
      createdAt: json['created_at'],
      debit: json['debit'] != null ? int.parse(json['debit']) : null,
      credit: json['credit'] != null ? int.parse(json['credit']) : null,
      total: int.parse(json['total']),
    );
  }
}
