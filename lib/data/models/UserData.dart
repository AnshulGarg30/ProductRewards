class UserData {
  final int id;
  final String name;
  final String image;
  final String phoneno;
  final String? playerid;
  final int status;
  final String dob;
  final int totalPoint;
  final int withdrawalPoint;
  final String? email;
  final int pendingPoint;
  final dynamic remainingPoint;

  UserData({
    required this.id,
    required this.name,
    required this.image,
    required this.phoneno,
    required this.playerid,
    required this.status,
    required this.dob,
    required this.totalPoint,
    required this.withdrawalPoint,
    required this.email,
    required this.pendingPoint,
    required this.remainingPoint,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    id: json['id'],
    name: json['name'],
    image: json['image'],
    phoneno: json['phoneno'],
    playerid: json['playerid'],
    status: json['status'],
    dob: json['dob'],
    totalPoint: json['total_point'],
    withdrawalPoint: json['withdrawal_point'],
    email: json['email'],
    pendingPoint: json['pending_point'],
    remainingPoint: json['remaining_point'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'image': image,
    'phoneno': phoneno,
    'playerid': playerid,
    'status': status,
    'dob': dob,
    'total_point': totalPoint,
    'withdrawal_point': withdrawalPoint,
    'email': email,
    'pending_point': pendingPoint,
    'remaining_point': remainingPoint,
  };
}
