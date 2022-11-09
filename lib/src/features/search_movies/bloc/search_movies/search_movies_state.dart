part of 'search_movies_bloc.dart';

abstract class SearchMoviesState extends Equatable {
  const SearchMoviesState();

  @override
  List<Object> get props => [];
}

class SearchMoviesInitial extends SearchMoviesState {}

class SearchMoviesLoading extends SearchMoviesState {}

class SearchMoviesSuccess extends SearchMoviesState {
  final List<MovieSummary> movies;

  const SearchMoviesSuccess(this.movies);

  @override
  List<Object> get props => [movies];
}

class SearchMoviesFailure extends SearchMoviesState {
  final FailureType type;

  const SearchMoviesFailure(this.type);

  @override
  List<Object> get props => [type];
}
