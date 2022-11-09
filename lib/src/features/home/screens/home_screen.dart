import 'package:flutter/material.dart';
import 'package:movie_mania/src/features/horizontal_movies/models/movie_list_type.dart';
import 'package:movie_mania/src/features/horizontal_movies/widgets/horizontal_movies_widget.dart';

import '../../../core/views/atomic/atoms/padding.dart';

enum _SelectedTab { home, search, person }

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: const [
              HorizontalMoviesWidget(
                title: 'Popular',
                type: MovieListType.category,
                param: 'popular',
              ),
              padding8,
              HorizontalMoviesWidget(
                title: 'Top rated',
                type: MovieListType.category,
                param: 'top_rated',
              ),
              padding8,
              HorizontalMoviesWidget(
                title: 'Upcoming',
                type: MovieListType.category,
                param: 'upcoming',
              ),
              padding8,
              HorizontalMoviesWidget(
                title: 'Action',
                type: MovieListType.genre,
                param: '28',
              ),
              padding8,
              HorizontalMoviesWidget(
                title: 'Horror',
                type: MovieListType.genre,
                param: '27',
              ),
              padding8,
              HorizontalMoviesWidget(
                title: 'Science Fiction',
                type: MovieListType.genre,
                param: '878',
              ),
              padding8,
              HorizontalMoviesWidget(
                title: 'Animation',
                type: MovieListType.genre,
                param: '16',
              ),
              padding8,
            ],
          ),
        ),
      ),
    );
  }
}
