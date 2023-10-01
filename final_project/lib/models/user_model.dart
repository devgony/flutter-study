class UserModel {
  final String uid;
  final String email;
  final bool hasAvatar;

  UserModel({
    required this.uid,
    required this.email,
    required this.hasAvatar,
  });

  UserModel.empty()
      : uid = "",
        email = "",
        hasAvatar = false;

  UserModel.fromJson(Map<String, dynamic> json)
      : uid = json['userId'],
        email = json['email'],
        hasAvatar = json['hasAvatar'] ?? false;

  Map<String, dynamic> toJson() {
    return {
      'userId': uid,
      'email': email,
      'hasAvatar': hasAvatar,
    };
  }

  copyWith({
    String? profileImage,
    String? uid,
    String? email,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      hasAvatar: hasAvatar,
    );
  }
}
