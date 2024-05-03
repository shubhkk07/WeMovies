import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/Models/movies.dart';
import 'package:movieapp/Repositoy/movie_repo.dart';

part 'movies_playing_event.dart';
part 'movies_playing_state.dart';

class MoviesPlayingBloc extends Bloc<MoviesPlayingEvent, MoviesPlayingState> {
  final List<Movie> _moviesList = [];

  List<Movie> get nowPlayingMovies => _moviesList;

  final MovieRepo _movieRepo = MovieRepo();

  MoviesPlayingBloc() : super(MoviesPlayingInitial()) {
    on<FetchNowPlaying>(_fethcNowPlayingMovies);
  }

  void _fethcNowPlayingMovies(FetchNowPlaying event, Emitter<MoviesPlayingState> emit) async {
    final List<Movie> list = await _movieRepo.getNowPlayingMovies();
    _moviesList.addAll(list);
    emit(MoviesPlayingLoaded(_moviesList));
  }
}
