import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_mania/src/core/extension/context_extension.dart';
import 'package:movie_mania/src/core/views/atomic/atoms/padding.dart';
import 'package:movie_mania/src/core/views/atomic/molecules/shimmer_item.dart';
import 'package:movie_mania/src/features/horizontal_movies/bloc/get_movies/movie_list_bloc.dart';
import 'package:movie_mania/src/features/horizontal_movies/models/movie_list_type.dart';

import '../../../core/app/injection_container.dart';
import '../../../core/views/atomic/molecules/movie_card.dart';
import '../../../core/views/widgets/failure_view.dart';
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
              return const MovieListShimmer();
            }
            if (state is MovieListSuccess) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 8,
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
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: ((_) {
                                  return MovieListScreen(
                                    title: title,
                                    type: type,
                                    param: param,
                                  );
                                }),
                              ),
                            );
                          },
                          child: Text(
                            'See all',
                            style: context.theme.textTheme.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: kMovieCardHeight,
                    child: ListView.builder(
                      itemCount: 8,
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 0,
                      ),
                      itemBuilder: (context, index) {
                        final movie = state.movies[index];
                        return Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: MovieCard(movie: movie),
                        );
                      },
                    ),
                  )
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

class MovieListShimmer extends StatelessWidget {
  const MovieListShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(padding:const  EdgeInsets.all(16) ,child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            ShimmerItem.rectangular(
              height: 22,
              width: 110,
            ),
            ShimmerItem.rectangular(
              height: 14,
              width: 52,
            ),
          ],
        ),
        padding8,
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ShimmerItem.circular(
                width: 160,
                height: kMovieCardHeight,
                shapeBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              padding8,
              ShimmerItem.circular(
                width: 160,
                height: kMovieCardHeight,
                shapeBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              padding8,
              ShimmerItem.circular(
                width: 160,
                height: kMovieCardHeight,
                shapeBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ],
          ),
        )
      ],
    ),);
  }
}
