import 'package:final_project/widgets/comment_tile.dart';
import 'package:final_project/widgets/fire.dart';
import 'package:final_project/widgets/mood_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/gaps.dart';
import '../models/comment_model.dart';
import '../models/mood_model.dart';
import '../view_models/mood_view_model.dart';
import '../view_models/settings_view_model.dart';
import '../widgets/avatar.dart';
import '../widgets/mood_card.dart';

class MoodDetailScreen extends ConsumerStatefulWidget {
  final MoodModel mood;

  const MoodDetailScreen({
    super.key,
    required this.mood,
  });

  @override
  ConsumerState<MoodDetailScreen> createState() => _MoodDetailScreenState();
}

class _MoodDetailScreenState extends ConsumerState<MoodDetailScreen>
    with TickerProviderStateMixin {
  String toTimeString(double value) {
    final duration = Duration(milliseconds: (value * 60000).toInt());
    final timeString =
        '${duration.inMinutes.toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';

    return timeString;
  }

  @override
  Widget build(BuildContext context) {
    final mood = widget.mood;
    final isDark = ref.watch(settingsProvider).darkMode;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Fire(size: 50),
            Text(
              mood.moodType.id.toUpperCase(),
            ),
            Gaps.h4,
            Text(
              mood.moodType.emoji,
              style: const TextStyle(fontSize: 40),
            ),
          ],
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
                  email: mood.creatorEmail,
                  uid: mood.creatorId,
                  size: 20,
                  hasAvatar: mood.hasAvatar,
                ),
                Gaps.h12,
                Text(
                  mood.creatorEmail,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
            Gaps.v12,
            Align(
              alignment: Alignment.center,
              child: Hero(
                tag: mood.id,
                child: MoodCard(
                  moodId: mood.moodType.id,
                  payload: mood.payload,
                ),
              ),
            ),
            Gaps.v12,
            StreamBuilder(
              stream: ref
                  .watch(moodProvider.notifier)
                  .subscribeMood(widget.mood.id),
              builder: ((context, AsyncSnapshot<MoodModel> snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                }
                if (snapshot.hasData) {
                  return MoodBottomBar(
                    mood: snapshot.data!,
                    color: isDark ? Colors.white : Colors.black,
                    onDetailScreen: true,
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
                  ref.watch(moodProvider.notifier).subscribeComments(mood.id),
              builder: (
                context,
                AsyncSnapshot<List<CommentModel>> snapshot,
              ) {
                if (snapshot.hasError) {
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
                        itemBuilder: (context, index) =>
                            CommentTile(comment: snapshot.data![index]),
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
