import 'package:cloud_firestore/cloud_firestore.dart';

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

enum Emotion {
  happy("happy", "😊"),
  thoughtful("thoughtful", "🤔"),
  love("love", "😍"),
  amazed("amazed", "🤩"),
  laughing("laughing", "😂"),
  sad("sad", "😢"),
  angry("angry", "😡"),
  shocked("shocked", "🤯");

  const Emotion(this.id, this.emoji);
  final String id;
  final String emoji;

  factory Emotion.from(String id) {
    return Emotion.values.firstWhere(
      (value) => value.id == id,
    );
  }
}
