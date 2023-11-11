import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class MoodModel {
  final String id;
  final String payload;
  final MoodType moodType;
  final Timestamp createdAt;
  final bool liked;
  final int likes;
  final int commentCount;
  final String creatorEmail;
  final String creatorId;
  final bool hasAvatar;

  MoodModel({
    required this.id,
    required this.payload,
    required this.moodType,
    required this.createdAt,
    this.liked = false,
    required this.likes,
    required this.creatorEmail,
    required this.creatorId,
    required this.commentCount,
    required this.hasAvatar,
  });

  MoodModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        payload = json['payload'],
        moodType = json['moodType'],
        createdAt = json['createdAt'] ?? Timestamp.now(),
        liked = json['liked'],
        creatorEmail = json['creatorEmail'],
        creatorId = json['creatorId'],
        commentCount = json['commentCount'],
        hasAvatar = json['hasAvatar'],
        likes = json['likes'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'payload': payload,
        'moodType': moodType,
        'createdAt': createdAt,
        'creatorEmail': creatorEmail,
        'creatorId': creatorId,
        'liked': liked,
        'likes': likes,
        'hasAvatar': hasAvatar,
        'commentCount': commentCount,
      };

  String yearMonthDay() {
    final createdAt = this.createdAt.toDate();
    return DateFormat('yyyy-MM-dd').format(createdAt);
  }
}

enum MoodType {
  happy("happy", "😊"),
  thoughtful("thoughtful", "🤔"),
  love("love", "😍"),
  amazed("amazed", "🤩"),
  laughing("laughing", "😂"),
  sad("sad", "😢"),
  angry("angry", "😡"),
  shocked("shocked", "🤯");

  const MoodType(this.id, this.emoji);
  final String id;
  final String emoji;

  factory MoodType.from(String id) {
    return MoodType.values.firstWhere(
      (value) => value.id == id,
    );
  }
}

MoodModel? fromSnapshotToMoodModel(
  DocumentSnapshot<Map<String, dynamic>> snapshot,
  String userId,
) {
  final doc = snapshot.data();
  if (doc == null || doc["moodType"] == null || doc["likedUsers"] == null) {
    return null;
  }

  final liked = doc["likedUsers"].contains(userId);

  return MoodModel.fromJson(
    {
      ...doc,
      "moodType": MoodType.from(doc["moodType"]),
      "id": snapshot.id,
      "liked": liked
    },
  );
}
