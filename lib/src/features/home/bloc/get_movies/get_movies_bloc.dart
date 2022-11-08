import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failure_types.dart';
import '../../models/movie_summary_model.dart';
import '../../repository/home_repository.dart';

part 'get_movies_event.dart';

part 'get_movies_state.dart';

class GetMoviesBloc extends Bloc<GetMoviesEvent, GetMoviesState> {
  final HomeRepository repository;

  GetMoviesBloc({
    required this.repository,
  }) : super(GetMoviesInitial()) {
    on<GetMovies>(_onGetMoviesEvent);
  }

  void _onGetMoviesEvent(
    GetMovies event,
    Emitter<GetMoviesState> emit,
  ) async {
    emit(GetMoviesLoading());

    final result = await repository.popularMovies();

    result.fold(
      (failure) => emit(
        GetMoviesFailure(FailureType.fromFailure(failure)),
      ),
      (projects) => emit(
        GetMoviesSuccess(projects),
      ),
    );
  }
}
