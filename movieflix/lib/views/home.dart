import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movieflix/consts.dart';
import 'package:movieflix/services/movie_service.dart';
import 'package:movieflix/widgets/horizontal_scrollable_movies.dart';

class Home extends ConsumerWidget {
  const Home({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Popular Movies", style: TextStyle(fontSize: 24)),
          Gaps.v20,
          HorizontalScrollableMovies(
            fetchType: FetchType.popular,
            imageType: ImageType.landscape,
          ),
          Gaps.v20,
          Text("Now In Cinemas", style: TextStyle(fontSize: 24)),
          Gaps.v20,
          HorizontalScrollableMovies(
            fetchType: FetchType.nowPlaying,
            imageType: ImageType.square,
            withTitle: true,
          ),
          Gaps.v20,
          Text("Coming soon", style: TextStyle(fontSize: 24)),
          Gaps.v20,
          HorizontalScrollableMovies(
            fetchType: FetchType.comingSoon,
            imageType: ImageType.square,
            withTitle: true,
          ),
        ],
      ),
    );
  }
}
