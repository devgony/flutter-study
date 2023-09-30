import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class PostModel {
  final String id;
  final String payload;
  final Mood mood;
  final Timestamp createdAt;

  PostModel({
    required this.id,
    required this.payload,
    required this.mood,
    required this.createdAt,
  });

  PostModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        payload = json['payload'],
        mood = json['mood'],
        createdAt = json['createdAt'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'payload': payload,
        'mood': mood,
        'createdAt': createdAt,
      };

  String elapsedString() {
    final now = DateTime.now();
    final createdAt = this.createdAt.toDate();
    final difference = now.difference(createdAt);

    String elapsed;
    if (difference.inMinutes < 60) {
      elapsed = '${difference.inMinutes} minutes';
    } else if (difference.inHours < 24) {
      elapsed = '${difference.inHours} hours';
    } else if (difference.inDays < 7) {
      elapsed = '${difference.inDays} days';
    } else {
      elapsed = DateFormat('yyyy-MM-dd').format(createdAt);
    }

    return '$elapsed ago';
  }
}

enum Mood {
  happy("happy", "😊"),
  thoughtful("thoughtful", "🤔"),
  love("love", "😍"),
  amazed("amazed", "🤩"),
  laughing("laughing", "😂"),
  sad("sad", "😢"),
  angry("angry", "😡"),
  shocked("shocked", "🤯");

  const Mood(this.id, this.emoji);
  final String id;
  final String emoji;

  factory Mood.from(String id) {
    return Mood.values.firstWhere(
      (value) => value.id == id,
    );
  }
}
