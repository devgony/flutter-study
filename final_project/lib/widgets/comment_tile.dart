import 'package:final_project/models/comment_model.dart';
import 'package:flutter/material.dart';

import '../utils.dart';
import 'avatar.dart';

class CommentTile extends StatelessWidget {
  final CommentModel comment;
  const CommentTile({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Avatar(
        email: comment.creatorEmail,
        uid: comment.creatorId,
        size: 20,
        hasAvatar: comment.hasAvatar,
      ),
      title: Text(comment.creatorEmail),
      subtitle: Text(comment.payload),
      trailing: Container(
        margin: const EdgeInsets.only(
          right: 12.0,
        ),
        child: Text(
          elapsedString(comment.createdAt),
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
