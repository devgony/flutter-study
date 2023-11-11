import 'package:final_project/widgets/write_comment_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../constants/gaps.dart';
import '../models/mood_model.dart';
import '../repositories/authentication_repository.dart';
import '../utils.dart';
import '../view_models/mood_view_model.dart';
import '../view_models/settings_view_model.dart';

class MoodBottomBar extends ConsumerWidget {
  final MoodModel mood;
  final Color color;
  final bool onDetailScreen;

  const MoodBottomBar({
    super.key,
    required this.mood,
    this.color = Colors.white,
    this.onDetailScreen = false,
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
                    final notifier = ref.read(moodProvider.notifier);
                    mood.liked
                        ? notifier.dislikeMood(
                            mood.id,
                          )
                        : notifier.likeMood(
                            mood.id,
                          );
                  },
                  child: FaIcon(
                    mood.liked
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
                      builder: (context) => WriteCommentScreen(
                        mood: mood,
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
                mood.creatorId == ref.read(authRepository).user?.uid
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
                                        .read(moodProvider.notifier)
                                        .deleteMood(mood.id);
                                    context.pop();
                                    if (onDetailScreen) {
                                      context.pop();
                                    }
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
              elapsedString(mood.createdAt),
              style: TextStyle(color: color),
            )
          ],
        ),
        Gaps.v8,
        Row(
          children: [
            Text(
              "${mood.likes} Likes",
              style: TextStyle(color: color),
            ),
            Text(
              " • ",
              style: TextStyle(color: color),
            ),
            Text(
              "${mood.commentCount} Comments",
              style: TextStyle(color: color),
            )
          ],
        ),
      ],
    );
  }
}
