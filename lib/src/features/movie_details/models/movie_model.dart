import 'package:equatable/equatable.dart';

class Movie extends Equatable {
  final int id;
  final String title;
  final String overview;

  final String imageUrl;
  final String backImageUrl;

  final List<String> genre;
  final String language;
  final double rating;
  final DateTime releaseDate;
  final Duration runtime;

  const Movie({
    required this.id,
    required this.title,
    required this.overview,
    required this.imageUrl,
    required this.backImageUrl,
    required this.genre,
    required this.language,
    required this.rating,
    required this.releaseDate,
    required this.runtime,
  });

  @override
  List<Object> get props => [
        id,
        title,
        overview,
        imageUrl,
        backImageUrl,
        genre,
        language,
        rating,
        releaseDate,
        runtime,
      ];

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json["id"],
      title: json["original_title"],
      imageUrl: json["poster_path"].toString(),
      rating: double.parse(json["vote_average"].toString()),
      backImageUrl: json["backdrop_path"],
      genre: List<String>.from(json["genres"].map((element) {
        return element["name"];
      })),
      language: json["spoken_languages"][0]["english_name"],
      overview: json["overview"],
      releaseDate: DateTime.parse(json["release_date"]),
      runtime: Duration(minutes: json["runtime"]),
    );
  }
}
