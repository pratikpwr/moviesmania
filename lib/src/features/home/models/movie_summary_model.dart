import 'package:equatable/equatable.dart';

class MovieSummary extends Equatable {
  final int id;
  final String title;
  final String imageUrl;
  final double rating;

  const MovieSummary({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.rating,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        imageUrl,
    rating,
      ];

  factory MovieSummary.fromJson( Map<String, dynamic> json) {
    return MovieSummary(
      id: json["id"],
      title: json["original_title"],
      imageUrl: json["poster_path"].toString(),
      rating: double.parse(json["vote_average"].toString()),
    );
  }

  // Map<String, Object?> toJson() {
  //   return {
  //     'title': title,
  //     'image_url': imageUrl,
  //     'description': description,
  //   };
  // }
}
