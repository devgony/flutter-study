import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movieflix/models/movie_detail_model.dart';
import 'package:movieflix/services/movie_service.dart';

import '../consts.dart';
import '../widgets/stars.dart';

class Detail extends ConsumerWidget {
  final int movieId;
  final FetchType fetchType;
  final String poster_path;
  const Detail({
    Key? key,
    required this.movieId,
    required this.fetchType,
    required this.poster_path,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leadingWidth: 200,
        leading: Row(
          children: [
            IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            const Text(
              "Back to list",
              style: TextStyle(
                fontSize: Sizes.size16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Colors.transparent,
      body: Hero(
        tag: "${fetchType.value}-$movieId",
        child: Material(
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: double.infinity,
                child: ColorFiltered(
                  colorFilter: const ColorFilter.mode(
                    Colors.grey,
                    BlendMode.darken,
                  ),
                  child: Image.network(
                    poster_path,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 10),
                child: FutureBuilder<MovieDetailModel>(
                  future: MovieService.fetchMovieById(movieId),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    final movie = snapshot.data!;
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          movie.title,
                          style: const TextStyle(
                            fontSize: Sizes.size36,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Stars(score: movie.vote_average / 2),
                        Gaps.v24,
                        Text(
                          "${(int.parse(movie.runtime) / 60).round()}h ${int.parse(movie.runtime) % 60}m | ${movie.genres}",
                          style: const TextStyle(fontSize: Sizes.size12),
                        ),
                        Gaps.v36,
                        const Text(
                          "Storyline",
                          style: TextStyle(
                            fontSize: Sizes.size24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Gaps.v8,
                        Text(
                          movie.overview,
                          style: const TextStyle(fontSize: Sizes.size16),
                        ),
                      ],
                    );
                  },
                ),
              ),
              Positioned(
                bottom: 0,
                child: Padding(
                  padding: const EdgeInsets.all(36),
                  child: SizedBox(
                    child: TextButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.yellow),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: Sizes.size56,
                          vertical: Sizes.size8,
                        ),
                        child: Text(
                          "Buy Ticket",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: Sizes.size24,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
