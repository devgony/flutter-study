import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movieflix/models/movie_model.dart';

import '../models/movie_detail_model.dart';

enum FetchType {
  popular('popular'),
  nowPlaying('now-playing'),
  comingSoon('coming-soon');

  const FetchType(
    this.value,
  );
  final String value;

  factory FetchType.getByCode(String code) {
    return FetchType.values.firstWhere(
      (value) => value.value == code,
    );
  }
}

class MovieService {
  static const String baseUrl = "https://movies-api.nomadcoders.workers.dev";

  static Future<List<MovieModel>> fetchMovies(FetchType fetchType) async {
    final url = Uri.parse('$baseUrl/${fetchType.value}');
    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception('Failed to load movies');
    }

    final movies = jsonDecode(response.body)['results'];

    return movies.map<MovieModel>((v) => MovieModel.fromJson(v)).toList();
  }

  static Future<MovieDetailModel> fetchMovieById(int id) async {
    final url = Uri.parse("$baseUrl/movie?id=$id");
    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception('Failed to load movie detail');
    }

    final movie = jsonDecode(response.body);

    return MovieDetailModel.fromJson(movie);
  }
}
