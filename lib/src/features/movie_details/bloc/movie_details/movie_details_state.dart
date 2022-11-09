part of 'movie_details_bloc.dart';

abstract class MovieDetailsState extends Equatable {
  const MovieDetailsState();

  @override
  List<Object> get props => [];
}

class MovieDetailsInitial extends MovieDetailsState {}

class MovieDetailsLoading extends MovieDetailsState {}

class MovieDetailsSuccess extends MovieDetailsState {
  final Movie movie;

  const MovieDetailsSuccess(this.movie);

  @override
  List<Object> get props => [movie];
}

class MovieDetailsFailure extends MovieDetailsState {
  final FailureType type;

  const MovieDetailsFailure(this.type);

  @override
  List<Object> get props => [type];
}
