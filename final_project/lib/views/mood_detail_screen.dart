import 'package:final_project/widgets/post_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/gaps.dart';
import '../models/comment_model.dart';
import '../models/post_model.dart';
import '../view_models/post_view_model.dart';
import '../view_models/settings_view_model.dart';
import '../widgets/avatar.dart';

class MoodDetailScreen extends ConsumerStatefulWidget {
  final PostModel post;

  const MoodDetailScreen({
    super.key,
    required this.post,
  });

  @override
  ConsumerState<MoodDetailScreen> createState() => _MoodDetailScreenState();
}

class _MoodDetailScreenState extends ConsumerState<MoodDetailScreen>
    with TickerProviderStateMixin {
  // late final AnimationController _progressController = AnimationController(
  //   vsync: this,
  //   duration: const Duration(minutes: 1),
  // );

  // late final AnimationController _marqueeController = AnimationController(
  //   vsync: this,
  //   duration: const Duration(
  //     seconds: 20,
  //   ),
  // );

  late final AnimationController _playPauseController = AnimationController(
    vsync: this,
    duration: const Duration(
      milliseconds: 500,
    ),
  );

  // late final Animation<Offset> _marqueeTween = Tween(
  //   begin: const Offset(0.1, 0),
  //   end: const Offset(-0.6, 0),
  // ).animate(_marqueeController);

  String toTimeString(double value) {
    final duration = Duration(milliseconds: (value * 60000).toInt());
    final timeString =
        '${duration.inMinutes.toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';

    return timeString;
  }

  @override
  void dispose() {
    // _progressController.dispose();
    // _marqueeController.dispose();
    super.dispose();
  }

  // void _onPlayPauseTap() {
  //   if (_playPauseController.isCompleted) {
  //     _playPauseController.reverse();
  //   } else {
  //     _playPauseController.forward();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final post = widget.post;
    final isDark = ref.watch(settingsProvider).darkMode;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${post.mood.emoji} ${post.mood.id.toUpperCase()} ${post.mood.emoji}",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24.0,
          vertical: 12,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Avatar(
                  email: post.creatorEmail,
                  uid: post.creatorId,
                  size: 20,
                ),
                Gaps.h12,
                Text(
                  post.creatorEmail,
                  style: TextStyle(
                    fontSize: 24,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
            Gaps.v12,
            Align(
              alignment: Alignment.center,
              child: Hero(
                tag: post.id,
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  height: 350,
                  width: 350,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        blurRadius: 10,
                        spreadRadius: 2,
                        offset: const Offset(0, 8),
                      )
                    ],
                    image: DecorationImage(
                      image: AssetImage(
                        "assets/${widget.post.mood.id}.jpg",
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    color: Colors.black.withOpacity(0.2),
                    child: Material(
                      type: MaterialType.transparency,
                      child: Text(
                        textAlign: TextAlign.center,
                        post.payload,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Gaps.v12,
            StreamBuilder(
              stream: ref
                  .watch(postProvider.notifier)
                  .subscribePost(widget.post.id),
              builder: ((context, AsyncSnapshot<PostModel> snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                }
                if (snapshot.hasData) {
                  return PostBottomBar(
                    post: snapshot.data!,
                    color: isDark ? Colors.white : Colors.black,
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }),
            ),
            const Divider(),
            StreamBuilder(
              stream:
                  ref.watch(postProvider.notifier).subscribeComments(post.id),
              builder: (
                context,
                AsyncSnapshot<List<CommentModel>> snapshot,
              ) {
                if (snapshot.hasError) {
                  print(snapshot.stackTrace.toString());
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                }
                if (snapshot.hasData) {
                  return Expanded(
                    child: Scrollbar(
                      thumbVisibility: true,
                      child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final comment = snapshot.data![index];
                          return ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: Avatar(
                              email: comment.creatorEmail,
                              uid: comment.creatorId,
                              size: 20,
                            ),
                            title: Text(comment.creatorEmail),
                            subtitle: Text(comment.payload),
                          );
                        },
                      ),
                    ),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
