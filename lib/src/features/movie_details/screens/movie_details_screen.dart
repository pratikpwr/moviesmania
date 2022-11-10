import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_mania/src/core/extension/context_extension.dart';
import 'package:movie_mania/src/core/views/widgets/failure_view.dart';
import 'package:movie_mania/src/core/views/widgets/loader.dart';
import 'package:movie_mania/src/features/horizontal_movies/models/movie_list_type.dart';
import 'package:movie_mania/src/features/horizontal_movies/widgets/horizontal_movies_widget.dart';
import 'package:movie_mania/src/features/movie_details/bloc/movie_details/movie_details_bloc.dart';
import 'package:movie_mania/src/features/movie_details/models/movie_model.dart';

import '../../../core/app/injection_container.dart';
import '../../../core/constants/api_constants.dart';
import '../../../core/views/atomic/atoms/padding.dart';
import '../../../core/views/atomic/molecules/movie_card.dart';

class MovieDetailsScreen extends StatelessWidget {
  const MovieDetailsScreen({
    super.key,
    required this.movieId,
  });

  final int movieId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MovieDetailsBloc(repository: sl())
        ..add(
          GetMovieDetails(
            movieId,
          ),
        ),
      child: Builder(
        builder: (context) {
          return Scaffold(
            extendBody: true,
            body: SingleChildScrollView(
              child: BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
                builder: (context, state) {
                  return Column(
                    children: [
                      if (state is MovieDetailsLoading) const Loader(),
                      if (state is MovieDetailsSuccess)
                        MovieDetailsWidget(movie: state.movie),
                      if (state is MovieDetailsFailure)
                        FailureView(
                          type: state.type,
                          onRetry: () => context
                              .read<MovieDetailsBloc>()
                              .add(GetMovieDetails(
                                movieId,
                              )),
                        ),
                      padding16,
                      HorizontalMoviesWidget(
                        title: 'Similar Movies',
                        type: MovieListType.similar,
                        param: '$movieId',
                      ),
                      padding8,
                    ],
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

class MovieDetailsWidget extends StatelessWidget {
  const MovieDetailsWidget({
    Key? key,
    required this.movie,
  }) : super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Column(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(150),
                    bottomRight: Radius.circular(150),
                  ),
                  child: Image.network(
                    "${ApiConstants.movieImageBaseUrl}${movie.backImageUrl}",
                    height: context.mediaQuery.size.height * 0.5,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                padding64,
                padding48
              ],
            ),
            Positioned(
              child: Container(
                height: kMovieCardHeight,
                width: 160,
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image: NetworkImage(
                      "${ApiConstants.movieImageBaseUrl}${movie.imageUrl}",
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
        padding16,
        Text(
          movie.title,
          style: context.theme.textTheme.headlineSmall,
        ),
        padding12,
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.star_rounded,
              size: 20,
            ),
            padding8,
            Text(
              movie.rating.toStringAsFixed(1),
              style: context.theme.textTheme.labelLarge,
            ),
            padding8,
            Text(
              '|',
              style: context.theme.textTheme.titleMedium,
            ),
            padding8,
            const Icon(
              Icons.calendar_month_rounded,
              size: 20,
            ),
            padding8,
            Text(
              movie.releaseDate.year.toString(),
              style: context.theme.textTheme.labelLarge,
            ),
            padding8,
            Text(
              '|',
              style: context.theme.textTheme.titleMedium,
            ),
            padding8,
            const Icon(
              Icons.watch_later_sharp,
              size: 18,
            ),
            padding8,
            Text(
              "${movie.runtime.inMinutes} minutes",
              style: context.theme.textTheme.labelLarge,
            ),
          ],
        ),
        padding8,
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.videocam_rounded,
            ),
            padding8,
            Text(
              movie.genre.join(", "),
              overflow: TextOverflow.fade,
              style: context.theme.textTheme.labelLarge,
            ),
          ],
        ),
        padding16,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Story line',
                style: context.theme.textTheme.titleLarge,
              ),
              padding8,
              Text(movie.overview),
            ],
          ),
        ),
      ],
    );
  }
}
