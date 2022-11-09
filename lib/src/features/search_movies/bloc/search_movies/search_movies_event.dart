part of 'search_movies_bloc.dart';

abstract class SearchMoviesEvent extends Equatable {
  const SearchMoviesEvent();
}

class SearchMovies extends SearchMoviesEvent {
  final String keyword;

  const SearchMovies(this.keyword);

  @override
  List<Object?> get props => [keyword];
}
