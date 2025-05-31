class Points {
  final int withdrawal;
  final int remaining;
  final int pending;
  final int total;

  Points({
    required this.withdrawal,
    required this.remaining,
    required this.pending,
    required this.total,
  });
}

class RewardList {
  final String id;
  final String merchantName;
  final String description;
  final int points;
  final DateTime date;

  RewardList({
    required this.id,
    required this.merchantName,
    required this.description,
    required this.points,
    required this.date,
  });
}
