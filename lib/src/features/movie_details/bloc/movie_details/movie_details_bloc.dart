import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failure_types.dart';
import '../../models/movie_model.dart';
import '../../repository/movie_details_repository.dart';

part 'movie_details_event.dart';

part 'movie_details_state.dart';

class MovieDetailsBloc extends Bloc<MovieDetailsEvent, MovieDetailsState> {
  final MovieDetailsRepository repository;

  MovieDetailsBloc({
    required this.repository,
  }) : super(MovieDetailsInitial()) {
    on<GetMovieDetails>(_onMovieDetailsEvent);
  }

  void _onMovieDetailsEvent(
    GetMovieDetails event,
    Emitter<MovieDetailsState> emit,
  ) async {
    emit(MovieDetailsLoading());

    final result = await repository.movieDetails(event.movieId);

    result.fold(
      (failure) => emit(
        MovieDetailsFailure(FailureType.fromFailure(failure)),
      ),
      (movie) => emit(
        MovieDetailsSuccess(movie),
      ),
    );
  }
}
