import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_mania/src/core/extension/context_extension.dart';
import 'package:movie_mania/src/features/horizontal_movies/bloc/get_movies/movie_list_bloc.dart';
import 'package:movie_mania/src/features/horizontal_movies/models/movie_list_type.dart';

import '../../../core/app/injection_container.dart';
import '../../../core/views/widgets/failure_view.dart';
import '../../../core/views/widgets/loader.dart';
import '../../../core/views/widgets/unknown_state.dart';
import '../screens/movie_list_screen.dart';

class HorizontalMoviesWidget extends StatelessWidget {
  final MovieListType type;
  final String param;
  final String title;

  const HorizontalMoviesWidget({
    Key? key,
    required this.title,
    required this.type,
    required this.param,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
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
              return const Loader();
            }
            if (state is MovieListSuccess) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          title,
                          style: context.theme.textTheme.titleLarge,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: ((_) {
                              return MovieListScreen(
                                title: title,
                                type: type,
                                param: param,
                              );
                            })));
                          },
                          child: Text(
                            'view all',
                            style: context.theme.textTheme.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                      height: 220,
                      child: ListView.builder(
                        itemCount: 8,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        itemBuilder: (context, index) {
                          final movie = state.movies[index];
                          return Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: Container(
                              height: 200,
                              width: 135,
                              decoration: BoxDecoration(
                                color: Colors.grey[400],
                                image: DecorationImage(
                                  image: NetworkImage(
                                    "https://image.tmdb.org/t/p/w600_and_h900_bestv2/${movie.imageUrl}",
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        },
                      ))
                ],
              );
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
        ));
  }
}
