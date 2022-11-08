import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_mania/src/features/home/bloc/get_movies/get_movies_bloc.dart';

import 'injection_container.dart';

List<BlocProvider> getBlocProviders() {
  return [
    BlocProvider<GetMoviesBloc>(
      create: (context) => sl<GetMoviesBloc>()..add(GetMovies()),
    ),
  ];
}
