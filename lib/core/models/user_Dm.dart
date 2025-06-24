class UserDm {
  static UserDm? currentUser;
  late  String userID;
   String? token;
  final int avatar;
  final String userName;
  final String email;
  final String phoneNumber;
  final List<int> watchList;
  final List<int> history;

  UserDm(  {
    this.token,
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
      userID: json["_id"],
      avatar: json['avaterId'],
      userName: json["name"],
      email: json['email'],
      phoneNumber: json['phone'],
      watchList: json['watchList']??[],
      history: json['history']??[],
    );
  }

  Map<String, Object> toJson() {
    return {
      "_id":userID,
      'avaterId':avatar,
      'name': userName,
      'email': email,
      'phone': phoneNumber,
      'watchList': watchList,
      'history': history,
    };
  }
}
