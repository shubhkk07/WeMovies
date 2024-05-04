part of 'top_rated_movies_bloc.dart';

@immutable
sealed class TopRatedMoviesEvent {}

class FetchTopRatedMovies extends TopRatedMoviesEvent {
  final bool? nextPage;

  FetchTopRatedMovies({this.nextPage});
}
