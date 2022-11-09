import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_mania/src/core/views/atomic/molecules/movies_grid_view.dart';
import 'package:movie_mania/src/features/horizontal_movies/bloc/get_movies/movie_list_bloc.dart';
import 'package:movie_mania/src/features/horizontal_movies/models/movie_list_type.dart';

import '../../../core/app/injection_container.dart';
import '../../../core/views/widgets/failure_view.dart';
import '../../../core/views/widgets/unknown_state.dart';

class MovieListScreen extends StatelessWidget {
  final MovieListType type;
  final String param;
  final String title;

  const MovieListScreen({
    Key? key,
    required this.title,
    required this.type,
    required this.param,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: BlocProvider(
          create: (context) => MovieListBloc(repository: sl())
            ..add(
              GetMovieList(
                type: type,
                params: param,
              ),
            ),
          child: BlocBuilder<MovieListBloc, MovieListState>(
            builder: (context, state) {
              if (state is MovieListLoading) {
                return const MovieGridViewShimmer();
              }
              if (state is MovieListSuccess) {
                return Column(children: [
                  Expanded(
                    child: MoviesGridView(
                      movies: state.movies,
                    ),
                  )
                ]);
              }
              if (state is MovieListFailure) {
                return FailureView(
                  type: state.type,
                  onRetry: () => context.read<MovieListBloc>().add(
                        GetMovieList(
                          type: type,
                          params: param,
                        ),
                      ),
                );
              }
              return const UnKnownState();
            },
          )),
    );
  }
}
