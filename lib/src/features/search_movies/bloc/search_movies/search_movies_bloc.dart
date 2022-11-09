import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_mania/src/features/home/models/movie_summary_model.dart';

import '../../../../core/errors/failure_types.dart';
import '../../repository/search_movies_repository.dart';

part 'search_movies_event.dart';

part 'search_movies_state.dart';

class SearchMoviesBloc extends Bloc<SearchMoviesEvent, SearchMoviesState> {
  final SearchMoviesRepository repository;

  SearchMoviesBloc({
    required this.repository,
  }) : super(SearchMoviesInitial()) {
    on<SearchMovies>(_onSearchMoviesEvent);
  }

  void _onSearchMoviesEvent(
    SearchMovies event,
    Emitter<SearchMoviesState> emit,
  ) async {
    emit(SearchMoviesLoading());

    final result = await repository.searchMovies(event.keyword);

    result.fold(
      (failure) => emit(
        SearchMoviesFailure(FailureType.fromFailure(failure)),
      ),
      (projects) => emit(
        SearchMoviesSuccess(projects),
      ),
    );
  }
}
