import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/mood_model.dart';
import '../view_models/mood_view_model.dart';
import 'grid_view_moods.dart';

class PostedMood extends ConsumerWidget {
  final double width;
  const PostedMood({super.key, required this.width});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StreamBuilder(
      stream: ref.watch(moodProvider.notifier).subscribeMyMoods(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print(snapshot.stackTrace.toString());
          print(snapshot.error.toString());
          return Center(
            child: Text(snapshot.error.toString()),
          );
        }
        if (snapshot.hasData) {
          final data = snapshot.data as List<MoodModel>;
          return GridViewMoods(
            data: data,
            width: width,
          );
        }
        return const Center(
          child: CircularProgressIndicator.adaptive(),
        );
      },
    );
  }
}
