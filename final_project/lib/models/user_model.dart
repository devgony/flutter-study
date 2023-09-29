class UserModel {
  final String? profileImage;
  final String uid;
  final String userName;

  UserModel({
    this.profileImage,
    required this.uid,
    required this.userName,
  });

  UserModel.fromJson(Map<String, dynamic> json)
      : profileImage = json['profileImage'],
        uid = json['userId'],
        userName = json['userName'];

  Map<String, dynamic> toJson() {
    return {
      'profileImage': profileImage,
      'userId': uid,
      'userName': userName,
    };
  }
}
