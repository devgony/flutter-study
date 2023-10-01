import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel {
  final String id;
  final String creatorId;
  final String creatorEmail;
  final String payload;
  final Timestamp createdAt;

  CommentModel({
    required this.id,
    required this.creatorId,
    required this.creatorEmail,
    required this.payload,
    required this.createdAt,
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
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'creatorId': creatorId,
        'creatorEmail': creatorEmail,
        'payload': payload,
        'createdAt': createdAt,
      };
}
