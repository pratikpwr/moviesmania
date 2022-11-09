import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failure_types.dart';
import '../../../home/models/movie_summary_model.dart';
import '../../models/movie_list_type.dart';
import '../../repository/horizontal_movies_repository.dart';

part 'movie_list_event.dart';

part 'movie_list_state.dart';

class MovieListBloc extends Bloc<MovieListEvent, MovieListState> {
  final HorizontalMoviesRepository repository;

  MovieListBloc({
    required this.repository,
  }) : super(MovieListInitial()) {
    on<GetMovieList>(_onMovieListEvent);
  }

  void _onMovieListEvent(
    GetMovieList event,
    Emitter<MovieListState> emit,
  ) async {
    emit(MovieListLoading());

    final result = await repository.movies(
      type: event.type,
      params: event.params,
    );

    result.fold(
      (failure) => emit(
        MovieListFailure(FailureType.fromFailure(failure)),
      ),
      (movies) => emit(
        MovieListSuccess(movies),
      ),
    );
  }
}
