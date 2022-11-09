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
            body: SafeArea(
              child: SingleChildScrollView(
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
    return Container(
      child: Column(
        children: [
          Image.network( "${ApiConstants.movieImageBaseUrl}${movie.backImageUrl}"),
          padding8,
          Text(movie.title,style: context.theme.textTheme.titleLarge,),
          padding8,
          Row(
            children: [
              Text(
                'Rating',
                style: context.theme.textTheme.bodyLarge?.copyWith(
                  fontSize: 13,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              padding8,
              Text(
                movie.rating.toStringAsFixed(1),
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
          ),
          padding8,
          Text(movie.overview),
        ],
      ),
    );
  }
}
