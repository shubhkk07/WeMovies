part of 'movies_playing_bloc.dart';

@immutable
sealed class MoviesPlayingEvent {}

class FetchNowPlaying extends MoviesPlayingEvent {
  final bool? nextPage;

  FetchNowPlaying({this.nextPage});
}
