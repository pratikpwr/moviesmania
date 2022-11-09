part of 'movie_list_bloc.dart';

abstract class MovieListEvent extends Equatable {
  const MovieListEvent();
}

class GetMovieList extends MovieListEvent {
  final MovieListType type;
  final String params;

  const GetMovieList({
    required this.params,
    required this.type,
  });

  @override
  List<Object?> get props => [type, params];
}
