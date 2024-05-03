part of 'top_rated_movies_bloc.dart';

@immutable
sealed class TopRatedMoviesState {}

final class TopRatedMoviesInitial extends TopRatedMoviesState {}

final class TopRatedMoviesLoading extends TopRatedMoviesState {}

final class TopRatedMoviesLoaded extends TopRatedMoviesState {
  final List<Movie> topRatedMovies;

  TopRatedMoviesLoaded({required this.topRatedMovies});
}
