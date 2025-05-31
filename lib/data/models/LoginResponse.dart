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
  final int id;
  final String name;
  final String image;
  final String phoneno;
  final String? playerid;
  final int status;
  final String dob;
  final String? totalPoint;
  final String? withdrawalPoint;
  final String? email;
  final String? pendingPoint;
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

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
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
  }
}
