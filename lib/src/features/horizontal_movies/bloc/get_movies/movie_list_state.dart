part of 'movie_list_bloc.dart';

abstract class MovieListState extends Equatable {
  const MovieListState();

  @override
  List<Object> get props => [];
}

class MovieListInitial extends MovieListState {}

class MovieListLoading extends MovieListState {}

class MovieListSuccess extends MovieListState {
  final List<MovieSummary> movies;

  const MovieListSuccess(this.movies);

  @override
  List<Object> get props => [movies];
}

class MovieListFailure extends MovieListState {
  final FailureType type;

  const MovieListFailure(this.type);

  @override
  List<Object> get props => [type];
}
