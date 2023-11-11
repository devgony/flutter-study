import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/mood_model.dart';
import '../view_models/user_view_model.dart';
import 'grid_view_moods.dart';

class LikedMood extends ConsumerWidget {
  final double width;
  const LikedMood({super.key, required this.width});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
      future: ref.watch(usersProvider.notifier).likedMoods(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
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
