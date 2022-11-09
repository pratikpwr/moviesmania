import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_mania/src/core/extension/context_extension.dart';
import 'package:movie_mania/src/core/views/atomic/atoms/textfield_item.dart';
import 'package:movie_mania/src/core/views/atomic/molecules/movies_grid_view.dart';

import '../../../core/app/injection_container.dart';
import '../../../core/views/widgets/failure_view.dart';
import '../../../core/views/widgets/loader.dart';
import '../../../core/views/widgets/unknown_state.dart';
import '../bloc/search_movies/search_movies_bloc.dart';

class SearchMoviesScreen extends StatelessWidget {
  SearchMoviesScreen({
    Key? key,
  }) : super(key: key);

  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchMoviesBloc(repository: sl()),
      child: Builder(builder: (context) {
        return Scaffold(
          body: SafeArea(
              child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: LabelledTextFieldItem(
                  controller: searchController,
                  hintText: 'Search movie',
                  textInputAction: TextInputAction.search,
                  suffixIcon: Icons.search_rounded,
                  onFieldSubmitted: (value) {
                    context.read<SearchMoviesBloc>().add(SearchMovies(value));
                  },
                ),
              ),
              BlocBuilder<SearchMoviesBloc, SearchMoviesState>(
                builder: (context, state) {
                  if (state is SearchMoviesInitial) {
                    return Center(
                      child: Text(
                        'Search Movies...',
                        style: context.theme.textTheme.titleLarge,
                      ),
                    );
                  }
                  if (state is SearchMoviesLoading) {
                    return const Loader();
                  }
                  if (state is SearchMoviesSuccess) {
                    if (state.movies.isEmpty) {
                      return Center(
                        child: Text(
                          'Movie Not Found!',
                          style: context.theme.textTheme.titleLarge,
                        ),
                      );
                    }
                    return Expanded(
                      child: MoviesGridView(
                        movies: state.movies,
                      ),
                    );
                  }
                  if (state is SearchMoviesFailure) {
                    return FailureView(
                      type: state.type,
                      onRetry: () => context.read<SearchMoviesBloc>().add(
                            SearchMovies(searchController.text),
                          ),
                    );
                  }
                  return const UnKnownState();
                },
              )
            ],
          )),
        );
      }),
    );
  }
}
