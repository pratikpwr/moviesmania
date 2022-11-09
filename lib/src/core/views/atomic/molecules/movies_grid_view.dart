import 'package:flutter/material.dart';
import 'package:movie_mania/src/core/views/atomic/molecules/movie_card.dart';

import '../../../../features/home/models/movie_summary_model.dart';

class MoviesGridView extends StatelessWidget {
  const MoviesGridView({
    Key? key,
    required this.movies,
  }) : super(key: key);

  final List<MovieSummary> movies;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 2 / 3,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      shrinkWrap: true,
      itemCount: movies.length,
      itemBuilder: (context, index) {
        return MovieCard(
          movie: movies[index],
        );
      },
    );
  }
}
