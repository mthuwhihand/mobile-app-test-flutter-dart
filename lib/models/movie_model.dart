class Movie {
  final int id;
  final String title;
  final String posterURL;
  final String imdbId;

  Movie({
    required this.id,
    required this.title,
    required this.posterURL,
    required this.imdbId,
  });

  // Phương thức để chuyển đổi từ JSON sang model Movie
  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'],
      posterURL: json['posterURL'],
      imdbId: json['imdbId'],
    );
  }

  // Phương thức để chuyển đổi từ model Movie sang JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'posterURL': posterURL,
      'imdbId': imdbId,
    };
  }
}
