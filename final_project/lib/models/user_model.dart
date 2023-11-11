class UserModel {
  final String uid;
  final String email;
  final bool hasAvatar;
  final List<String> likedMoods;

  UserModel({
    required this.uid,
    required this.email,
    required this.hasAvatar,
    this.likedMoods = const [],
  });

  UserModel.empty()
      : uid = "",
        email = "",
        hasAvatar = false,
        likedMoods = [];

  UserModel.fromJson(Map<String, dynamic> json)
      : uid = json['userId'],
        email = json['email'],
        hasAvatar = json['hasAvatar'] ?? false,
        likedMoods = json['likedMoods'] ?? [];

  Map<String, dynamic> toJson() {
    return {
      'userId': uid,
      'email': email,
      'hasAvatar': hasAvatar,
      'likedMoods': likedMoods,
    };
  }

  copyWith({
    required bool hasAvatar,
  }) {
    return UserModel(
      hasAvatar: hasAvatar,
      uid: uid,
      email: email,
      likedMoods: likedMoods,
    );
  }
}
