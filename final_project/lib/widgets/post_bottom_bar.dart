import 'package:final_project/widgets/write_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../constants/gaps.dart';
import '../models/post_model.dart';
import '../repositories/authentication_repository.dart';
import '../utils.dart';
import '../view_models/post_view_model.dart';
import '../view_models/settings_view_model.dart';
import '../views/home_screen.dart';

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
                Gaps.h12,
                post.creatorId == ref.read(authRepository).user!.uid
                    ? InkWell(
                        onTap: () {
                          showCupertinoDialog(
                            context: context,
                            builder: (context) => CupertinoAlertDialog(
                              title: const Text("Are you sure to Delete?"),
                              content: const Text("Can't be recovered"),
                              actions: [
                                CupertinoDialogAction(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: const Text("No"),
                                ),
                                CupertinoDialogAction(
                                  onPressed: () {
                                    ref
                                        .read(postProvider.notifier)
                                        .deletePost(post.id);
                                    context.push(HomeScreen.routeURL);
                                  },
                                  isDestructiveAction: true,
                                  child: const Text("Yes"),
                                ),
                              ],
                            ),
                          );
                        },
                        child: FaIcon(
                          FontAwesomeIcons.trashCan,
                          color: color,
                        ),
                      )
                    : const SizedBox.shrink(),
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
