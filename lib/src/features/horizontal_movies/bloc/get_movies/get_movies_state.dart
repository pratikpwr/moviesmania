part of 'get_movies_bloc.dart';

abstract class GetMoviesState extends Equatable {
  const GetMoviesState();

  @override
  List<Object> get props => [];
}

class GetMoviesInitial extends GetMoviesState {}

class GetMoviesLoading extends GetMoviesState {}

class GetMoviesSuccess extends GetMoviesState {
  final List<MovieSummary> movies;

  const GetMoviesSuccess(this.movies);

  @override
  List<Object> get props => [movies];
}

class GetMoviesFailure extends GetMoviesState {
  final FailureType type;

  const GetMoviesFailure(this.type);

  @override
  List<Object> get props => [type];
}
