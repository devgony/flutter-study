class UserModel {
  final String profileImage;
  final String uid;
  final String userName;
  final int followers;

  UserModel({
    required this.profileImage,
    required this.uid,
    required this.userName,
    required this.followers,
  });

  UserModel.fromJson(Map<String, dynamic> json)
      : profileImage = json['profileImage'],
        uid = json['userId'],
        userName = json['userName'],
        followers = json['followers'];

  Map<String, dynamic> toJson() {
    return {
      'profileImage': profileImage,
      'userId': uid,
      'userName': userName,
      'followers': followers,
    };
  }
}
