import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

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

class MovieRepo {
  static const String baseUrl = "https://movies-api.nomadcoders.workers.dev";

  Future<List<dynamic>> fetchMovies(FetchType fetchType) async {
    final url = Uri.parse('$baseUrl/${fetchType.value}');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['results'];
    } else {
      throw Exception('Failed to load movies');
    }
  }

  Future<dynamic> fetchMovieById(int id) async {
    final url = Uri.parse("$baseUrl/movie?id=$id");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    throw Error();
  }
}

final movieRepoProvider = Provider<MovieRepo>((ref) => MovieRepo());
