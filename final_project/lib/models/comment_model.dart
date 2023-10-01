import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel {
  final String id;
  final String creatorId;
  final String creatorEmail;
  final String payload;
  final Timestamp createdAt;
  final bool hasAvatar;

  CommentModel({
    required this.id,
    required this.creatorId,
    required this.creatorEmail,
    required this.payload,
    required this.createdAt,
    required this.hasAvatar,
  });

  factory CommentModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return CommentModel(
      id: json['id'],
      creatorId: json['creatorId'],
      creatorEmail: json['creatorEmail'],
      payload: json['payload'],
      createdAt: json['createdAt'],
      hasAvatar: json['hasAvatar'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'creatorId': creatorId,
        'creatorEmail': creatorEmail,
        'payload': payload,
        'hasAvatar': hasAvatar,
        'createdAt': createdAt,
      };
}
