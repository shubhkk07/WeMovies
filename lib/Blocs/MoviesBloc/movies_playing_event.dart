part of 'movies_playing_bloc.dart';

@immutable
sealed class MoviesPlayingEvent {}

class FetchNowPlaying extends MoviesPlayingEvent {}
