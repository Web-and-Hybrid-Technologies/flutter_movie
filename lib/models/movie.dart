class Movie {
  final String title;
  final String year;
  final String imdbId;

  Movie({required this.title, required this.year, required this.imdbId});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json["Title"],
      year: json["Year"],
      imdbId: json["imdbID"]
      );
  }
}