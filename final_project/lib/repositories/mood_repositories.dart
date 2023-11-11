import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/comment_model.dart';
import '../models/mood_model.dart';

class MoodRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  subscribeMyMoods(String userId) => _db
      .collection("moods")
      .where("creatorId", isEqualTo: userId)
      .orderBy("createdAt", descending: true)
      .snapshots()
      .map(
        (event) => event.docs
            .map(
              (doc) => fromSnapshotToMoodModel(doc, userId),
            )
            .where((x) => x != null)
            .map((e) => e!)
            .toList(),
      );

  Stream<List<CommentModel>> subscribeComments(String moodId) => _db
      .collection("moods")
      .doc(moodId)
      .collection("comments")
      .orderBy("createdAt", descending: true)
      .snapshots()
      .map(
        (event) => event.docs
            .map(
              (doc) => CommentModel.fromJson({...doc.data(), "id": doc.id}),
            )
            .toList(),
      );

  Future<void> addComment(
    String id,
    String payload,
    String uid,
    String email,
    bool hasAvatar,
  ) async {
    final commentData = {
      "payload": payload,
      "createdAt": FieldValue.serverTimestamp(),
      "creatorId": uid,
      "creatorEmail": email,
      "hasAvatar": hasAvatar,
    };

    await _db
        .collection("moods")
        .doc(id)
        .collection("comments")
        .add(commentData);

    await _db.collection("moods").doc(id).update(
      {
        "commentCount": FieldValue.increment(1),
      },
    );
  }

  Stream<MoodModel> subscribeMood(String userId, String moodId) => _db
      .collection("moods")
      .doc(moodId)
      .snapshots()
      .map(
        (event) => fromSnapshotToMoodModel(event, userId),
      )
      .where((x) => x != null)
      .map((e) => e!);

  dislikeMood(String id, String userId) async {
    _db.collection("moods").doc(id).update({
      "likes": FieldValue.increment(-1),
      "likedUsers": FieldValue.arrayRemove([userId]),
    });

    await _db.collection("users").doc(userId).update(
      {
        "likedMoods": FieldValue.arrayRemove([id]),
      },
    );
  }

  likeMood(String id, String userId) async {
    _db.collection("moods").doc(id).update({
      "likes": FieldValue.increment(1),
      "likedUsers": FieldValue.arrayUnion([userId]),
    });

    await _db.collection("users").doc(userId).update(
      {
        "likedMoods": FieldValue.arrayUnion([id]),
      },
    );
  }

  Future<void> createMood({
    required String payload,
    required String moodType,
    required String uid,
    required String email,
    required bool hasAvatar,
  }) async {
    final mood = {
      "payload": payload,
      "moodType": moodType.toString(),
      "createdAt": FieldValue.serverTimestamp(),
      "likes": 0,
      "likedUsers": [],
      "creatorEmail": email,
      "creatorId": uid,
      "commentCount": 0,
      "hasAvatar": hasAvatar,
    };
    await _db.collection("moods").add(mood);
  }

  Future<void> deleteMood(String id) async {
    await _db.collection("moods").doc(id).delete();
  }

  Stream<List<MoodModel>> subscribeMoods(String userId) => _db
      .collection("moods")
      .orderBy("createdAt", descending: true)
      .snapshots()
      .map(
        (event) => event.docs
            .map(
              (doc) {
                return fromSnapshotToMoodModel(doc, userId);
              },
            )
            .where((x) => x != null)
            .map((e) => e!)
            .toList(),
      );

  Future<String> uploadThread(
    File file,
    String authorId,
  ) async {
    final fileName =
        "/threads/$authorId/${DateTime.now().millisecondsSinceEpoch.toString()}";
    final ref = _storage.ref().child(fileName);
    await ref.putFile(file);

    return fileName;
  }
}

final moodRepository = Provider(
  (ref) => MoodRepository(),
);
