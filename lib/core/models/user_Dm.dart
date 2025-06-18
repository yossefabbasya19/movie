class UserDm {
  static UserDm? currentUser;
  late  String userID;
  final String avatar;
  final String userName;
  final String email;
  final String phoneNumber;
  final List watchList;
  final List history;

  UserDm( {
    required this.userID,
    required this.avatar,
    required this.userName,
    required this.email,
    required this.phoneNumber,
    required this.watchList,
    required this.history,
  });

  factory UserDm.fromJson(json) {
    return UserDm(
      userID: json["userID"],
      avatar: json['avatar'],
      userName: json["userName"],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      watchList: json['watchList'],
      history: json['history'],
    );
  }

  Map<String, Object> toJson() {
    return {
      "userID":userID,
      'avatar':avatar,
      'userName': userName,
      'email': email,
      'phoneNumber': phoneNumber,
      'watchList': watchList,
      'history': history,
    };
  }
}
