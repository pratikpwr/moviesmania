part of 'movie_details_bloc.dart';

abstract class MovieDetailsEvent extends Equatable {
  const MovieDetailsEvent();
}

class GetMovieDetails extends MovieDetailsEvent {
  final int movieId;

  const GetMovieDetails(this.movieId);

  @override
  List<Object?> get props => [movieId];
}
