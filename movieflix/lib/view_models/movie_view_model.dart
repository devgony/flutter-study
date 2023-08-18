import 'dart:async';

import 'package:movieflix/models/movie_model.dart';
import 'package:movieflix/repos/movie_repo.dart';
import 'package:riverpod/riverpod.dart';

import '../models/movie_detail_model.dart';

class MovieViewModel extends AsyncNotifier<void> {
  late final MovieRepo _movieRepo;

  @override
  Future<void> build() async {
    _movieRepo = ref.read(movieRepoProvider);
  }

  Future<List<MovieModel>> getMovies(FetchType fetchType) async {
    final movies = await _movieRepo.fetchMovies(fetchType);
    final movieModels = movies.map((v) => MovieModel.fromJson(v)).toList();

    return movieModels;
  }

  Future<MovieDetailModel> getMovieById(int id) async {
    final movie = await _movieRepo.fetchMovieById(id);
    final movieModel = MovieDetailModel.fromJson(movie);

    return movieModel;
  }
}

final movieProvider = AsyncNotifierProvider<MovieViewModel, void>(
  () => MovieViewModel(),
);
