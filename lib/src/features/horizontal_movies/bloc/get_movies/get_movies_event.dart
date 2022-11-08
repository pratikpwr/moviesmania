part of 'get_movies_bloc.dart';

abstract class GetMoviesEvent extends Equatable {
  const GetMoviesEvent();
}

class GetMovies extends GetMoviesEvent {
  @override
  List<Object?> get props => [];
}
