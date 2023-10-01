class UserModel {
  final String uid;
  final String email;
  final bool hasAvatar;
  final List<String> likedPosts;

  UserModel({
    required this.uid,
    required this.email,
    required this.hasAvatar,
    this.likedPosts = const [],
  });

  UserModel.empty()
      : uid = "",
        email = "",
        hasAvatar = false,
        likedPosts = [];

  UserModel.fromJson(Map<String, dynamic> json)
      : uid = json['userId'],
        email = json['email'],
        hasAvatar = json['hasAvatar'] ?? false,
        likedPosts = json['likedPosts'] ?? [];

  Map<String, dynamic> toJson() {
    return {
      'userId': uid,
      'email': email,
      'hasAvatar': hasAvatar,
      'likedPosts': likedPosts,
    };
  }

  copyWith({
    required bool hasAvatar,
  }) {
    return UserModel(
      hasAvatar: hasAvatar,
      uid: uid,
      email: email,
      likedPosts: likedPosts,
    );
  }
}
