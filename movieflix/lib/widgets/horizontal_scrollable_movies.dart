import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/movie_model.dart';
import '../services/movie_service.dart';
import '../views/detail.dart';

enum ImageType {
  square(150),
  landscape(300);

  final double value;
  const ImageType(
    this.value,
  );
}

class HorizontalScrollableMovies extends ConsumerWidget {
  final ImageType imageType;
  final bool withTitle;
  final FetchType fetchType;

  const HorizontalScrollableMovies({
    super.key,
    required this.imageType,
    required this.fetchType,
    this.withTitle = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<List<MovieModel>>(
      future: MovieService.fetchMovies(fetchType),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final movies = snapshot.data!;

          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final movie in movies) ...[
                  SizedBox(
                    width: imageType.value,
                    height: null,
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                fullscreenDialog: true,
                                builder: (context) {
                                  return Detail(
                                    movieId: movie.id,
                                    fetchType: fetchType,
                                    poster_path: movie.poster_path,
                                  );
                                },
                              ),
                            );
                          },
                          child: Hero(
                            tag: "${fetchType.value}-${movie.id}",
                            child: Container(
                              margin: const EdgeInsets.only(left: 10),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(
                                  movie.poster_path,
                                  fit: BoxFit.cover,
                                  width: imageType.value,
                                  height: 150,
                                ),
                              ),
                            ),
                          ),
                        ),
                        withTitle
                            ? Container(
                                margin: const EdgeInsets.only(left: 10),
                                child: Text(
                                  movie.title,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                ]
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
