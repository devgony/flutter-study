class MovieDetailModel {
  final String title, overview, runtime, poster_path, genres;
  final double vote_average;

  MovieDetailModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        overview = json['overview'],
        vote_average = json['vote_average'].toDouble(),
        runtime = json['runtime'].toString(),
        poster_path = "https://image.tmdb.org/t/p/w500" + json['poster_path'],
        genres = json['genres'].map((e) => e['name']).join(", ");
}
