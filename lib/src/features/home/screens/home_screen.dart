import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_mania/src/core/extension/context_extension.dart';

import '../../../core/views/widgets/failure_view.dart';
import '../../../core/views/widgets/loader.dart';
import '../../../core/views/widgets/unknown_state.dart';
import '../bloc/get_movies/get_movies_bloc.dart';
import '../models/movie_summary_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies'),
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<GetMoviesBloc, GetMoviesState>(
          builder: (context, state) {
            if (state is GetMoviesLoading) {
              return const Loader();
            }
            if (state is GetMoviesSuccess) {
              return HorizontalMovies(title: "Popular", projects: state.movies);
            }
            if (state is GetMoviesFailure) {
              return FailureView(
                type: state.type,
                onRetry: () => context.read<GetMoviesBloc>().add(GetMovies()),
              );
            }
            return const UnKnownState();
          },
        ),
      ),
    );
  }
}

class HorizontalMovies extends StatelessWidget {
  final String title;
  final List<MovieSummary> projects;

  const HorizontalMovies({
    Key? key,
    required this.title,
    required this.projects,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Text(
            title,
            style: context.theme.textTheme.titleLarge,
          ),
        ),
        SizedBox(
            height: 220,
            child: ListView.builder(
              itemCount: projects.length,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              itemBuilder: (context, index) {
                final project = projects[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Container(
                    height: 200,
                    width: 135,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      image: DecorationImage(
                        image: NetworkImage(
                          "https://image.tmdb.org/t/p/w600_and_h900_bestv2/${project.imageUrl}",
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
}
