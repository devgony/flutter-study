import 'package:cloud_firestore/cloud_firestore.dart';

class ThreadModel {
  final String authorId;
  final String body;
  final List<String>? imageUrls;
  final Timestamp createdAt;

  ThreadModel({
    required this.authorId,
    required this.body,
    this.imageUrls,
    required this.createdAt,
  });

  ThreadModel.fromJson(Map<String, dynamic> json)
      : authorId = json['authorId'],
        body = json['body'],
        imageUrls = List<String>.from(json['imageUrls']),
        createdAt = json['createdAt'];

  Map<String, dynamic> toJson() {
    return {
      'authorId': authorId,
      'body': body,
      'imageUrls': imageUrls,
      'createdAt': createdAt
    };
  }
}
