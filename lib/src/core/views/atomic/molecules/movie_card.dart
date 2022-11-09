import 'package:flutter/material.dart';
import 'package:movie_mania/src/core/extension/context_extension.dart';

import '../../../../features/home/models/movie_summary_model.dart';
import '../atoms/padding.dart';

const kMovieCardHeight = 250.0;

class MovieCard extends StatelessWidget {
  const MovieCard({
    Key? key,
    required this.movie,
  }) : super(key: key);
  final MovieSummary movie;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kMovieCardHeight,
      width: 160,
      decoration: BoxDecoration(
        color: Colors.grey[400],
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: NetworkImage(
            "https://image.tmdb.org/t/p/w600_and_h900_bestv2/${movie.imageUrl}",
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Container(
          width: double.maxFinite,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.black38,
                Colors.black54,
                Colors.black87,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
          padding: const EdgeInsets.all(6),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                movie.title,
                style: context.theme.textTheme.bodyLarge?.copyWith(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 2,
                overflow: TextOverflow.fade,
              ),
              padding4,
              Row(
                children: [
                  Text(
                    movie.rating.toString(),
                    style: context.theme.textTheme.bodyLarge?.copyWith(
                      fontSize: 13,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Icon(
                    Icons.star_rounded,
                    color: Colors.yellow,
                    size: 16,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
