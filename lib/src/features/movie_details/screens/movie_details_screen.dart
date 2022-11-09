import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_mania/src/core/views/widgets/failure_view.dart';
import 'package:movie_mania/src/core/views/widgets/loader.dart';
import 'package:movie_mania/src/features/horizontal_movies/models/movie_list_type.dart';
import 'package:movie_mania/src/features/horizontal_movies/widgets/horizontal_movies_widget.dart';
import 'package:movie_mania/src/features/movie_details/bloc/movie_details/movie_details_bloc.dart';

import '../../../core/app/injection_container.dart';
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
                        if (state is MovieDetailsLoading) ...[Loader()],
                        if (state is MovieDetailsSuccess) ...[
                          Text(
                            state.movie.title,
                          ),
                          Text(
                            state.movie.overview,
                          ),
                        ],
                        if (state is MovieDetailsFailure) ...[
                          FailureView(
                            type: state.type,
                            onRetry: () => context
                                .read<MovieDetailsBloc>()
                                .add(GetMovieDetails(
                                  movieId,
                                )),
                          ),
                        ],
                        padding8,
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
