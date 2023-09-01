class UserModel {
  final String profileImage;
  final String userId;
  final String userName;
  final String followers;

  UserModel({
    required this.profileImage,
    required this.userId,
    required this.userName,
    required this.followers,
  });

  UserModel.fromJson(Map<String, dynamic> json)
      : profileImage = json['profileImage'],
        userId = json['userId'],
        userName = json['userName'],
        followers = json['followers'];
}
