import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/comment_model.dart';
import '../models/post_model.dart';

class PostRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  subscribeMyPosts(String userId) => _db
      .collection("posts")
      .where("creatorId", isEqualTo: userId)
      .orderBy("createdAt", descending: true)
      .snapshots()
      .map(
        (event) => event.docs
            .map(
              (doc) => fromSnapshotToPostModel(doc, userId),
            )
            .where((x) => x != null)
            .map((e) => e!)
            .toList(),
      );

  Stream<List<CommentModel>> subscribeComments(String postId) => _db
      .collection("posts")
      .doc(postId)
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
        .collection("posts")
        .doc(id)
        .collection("comments")
        .add(commentData);

    await _db.collection("posts").doc(id).update(
      {
        "commentCount": FieldValue.increment(1),
      },
    );
  }

  Stream<PostModel> subscribePost(String userId, String postId) => _db
      .collection("posts")
      .doc(postId)
      .snapshots()
      .map(
        (event) => fromSnapshotToPostModel(event, userId),
      )
      .where((x) => x != null)
      .map((e) => e!);

  dislikePost(String id, String userId) async {
    _db.collection("posts").doc(id).update({
      "likes": FieldValue.increment(-1),
      "likedUsers": FieldValue.arrayRemove([userId]),
    });

    await _db.collection("users").doc(userId).update(
      {
        "likedPosts": FieldValue.arrayRemove([id]),
      },
    );
  }

  likePost(String id, String userId) async {
    _db.collection("posts").doc(id).update({
      "likes": FieldValue.increment(1),
      "likedUsers": FieldValue.arrayUnion([userId]),
    });

    await _db.collection("users").doc(userId).update(
      {
        "likedPosts": FieldValue.arrayUnion([id]),
      },
    );
  }

  Future<void> createPost({
    required String payload,
    required String mood,
    required String uid,
    required String email,
    required bool hasAvatar,
  }) async {
    final post = {
      "payload": payload,
      "mood": mood.toString(),
      "createdAt": FieldValue.serverTimestamp(),
      "likes": 0,
      "likedUsers": [],
      "creatorEmail": email,
      "creatorId": uid,
      "commentCount": 0,
      "hasAvatar": hasAvatar,
    };
    await _db.collection("posts").add(post);
  }

  Future<void> deletePost(String id) async {
    await _db.collection("posts").doc(id).delete();
  }

  Stream<List<PostModel>> subscribePosts(String userId) => _db
      .collection("posts")
      .orderBy("createdAt", descending: true)
      .snapshots()
      .map(
        (event) => event.docs
            .map(
              (doc) {
                return fromSnapshotToPostModel(doc, userId);
              },
            )
            .where((x) => x != null)
            .map((e) => e!)
            .toList(),
      );

  // Future<List<PostModel>> searchPosts(String PostId, String keyword) async {
  // final QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
  // .instance
  // .collection("Posts")
  // .where("PostName", isGreaterThanOrEqualTo: keyword)
  // .where("PostName", isLessThanOrEqualTo: '$keyword\uf8ff')
  // .get();
//
  // final List<PostModel> Posts =
  // snapshot.docs.map((doc) => PostModel.fromJson(doc.data())).toList();
//
  // return Posts;
  // }

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

final postRepository = Provider(
  (ref) => PostRepository(),
);
