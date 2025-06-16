class LoginResponse {
  final bool status;
  final String message;
  final UserData data;

  LoginResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      status: json['status'],
      message: json['message'],
      data: UserData.fromJson(json['data']),
    );
  }
}

class UserData {
  final String id;
  final String name;
  final String image;
  final String phoneno;
  final String? playerid;
  final String status;
  final String dob;
  final String? totalPoint;
  final String? withdrawalPoint;
  final String? email;
  final String? pendingPoint;
  final String? remainingPoint;

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

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'].toString(),
      name: json['name'],
      image: json['image'],
      phoneno: json['phoneno'],
      playerid: json['playerid'],
      status: json['status'].toString(),
      dob: json['dob'],
      totalPoint: json['total_point'],
      withdrawalPoint: json['withdrawal_point'],
      email: json['email'],
      pendingPoint: json['pending_point'],
      remainingPoint: json['remaining_point'],
    );
  }

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
