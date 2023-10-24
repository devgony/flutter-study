class MovieModel {
  final int id;
  final String title;
  final String backdrop_path;
  final String poster_path;

  MovieModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        backdrop_path =
            "https://image.tmdb.org/t/p/w500${json['backdrop_path'] ?? ""}",
        poster_path = "https://image.tmdb.org/t/p/w500" + json['poster_path'];
}
