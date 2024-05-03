part of 'movies_playing_bloc.dart';

@immutable
sealed class MoviesPlayingState {}

final class MoviesPlayingInitial extends MoviesPlayingState {}

final class MoviesPlayingLoading extends MoviesPlayingState {}

final class MoviesPlayingLoaded extends MoviesPlayingState {
  final List<Movie> list;
  MoviesPlayingLoaded(this.list);
}
