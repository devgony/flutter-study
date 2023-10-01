import 'package:final_project/widgets/write_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constants/gaps.dart';
import '../models/post_model.dart';
import '../utils.dart';
import '../view_models/post_view_model.dart';
import '../view_models/settings_view_model.dart';

class PostBottomBar extends ConsumerWidget {
  final PostModel post;
  final Color color;

  const PostBottomBar({
    super.key,
    required this.post,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () {
                    final notifier = ref.read(postProvider.notifier);
                    post.liked
                        ? notifier.dislikePost(
                            post.id,
                          )
                        : notifier.likePost(
                            post.id,
                          );
                  },
                  child: FaIcon(
                    post.liked
                        ? FontAwesomeIcons.solidHeart
                        : FontAwesomeIcons.heart,
                    color: color,
                  ),
                ),
                Gaps.h12,
                InkWell(
                  onTap: () {
                    final isDark = ref.watch(settingsProvider).darkMode;
                    showModalBottomSheet(
                      backgroundColor: isDark ? Colors.black : Colors.white,
                      context: context,
                      builder: (context) => WriteScreen(
                        post: post,
                      ),
                      constraints: BoxConstraints(
                        maxHeight: getScreenHeight(context) * 0.6,
                      ),
                      isScrollControlled: true,
                    );
                  },
                  child: FaIcon(
                    FontAwesomeIcons.comment,
                    color: color,
                  ),
                ),
              ],
            ),
            Text(
              textAlign: TextAlign.end,
              post.elapsedString(),
              style: TextStyle(color: color),
            )
          ],
        ),
        Gaps.v8,
        Row(
          children: [
            Text(
              "${post.likes} Likes",
              style: TextStyle(color: color),
            ),
            Text(
              " • ",
              style: TextStyle(color: color),
            ),
            Text(
              "${post.commentCount} Comments",
              style: TextStyle(color: color),
            )
          ],
        ),
      ],
    );
  }
}
