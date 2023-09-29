import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/views/post_screen.dart';

class PostModel {
  final String id;
  final String payload;
  final Emotion emotion;
  final Timestamp createdAt;

  PostModel({
    required this.id,
    required this.payload,
    required this.emotion,
    required this.createdAt,
  });

  PostModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        payload = json['payload'],
        emotion = json['emotion'],
        createdAt = json['createdAt'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'payload': payload,
        'emotion': emotion,
        'createdAt': createdAt,
      };
}
