import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/Models/movies.dart';
import 'package:movieapp/Repositoy/movie_repo.dart';

part 'movies_playing_event.dart';
part 'movies_playing_state.dart';

class MoviesPlayingBloc extends Bloc<MoviesPlayingEvent, MoviesPlayingState> {
  final List<Movie> _moviesList = [];

  int _pageCount = 1;

  List<Movie> get nowPlayingMovies => _moviesList;

  final MovieRepo _movieRepo = MovieRepo();

  MoviesPlayingBloc() : super(MoviesPlayingInitial()) {
    on<FetchNowPlaying>(_fethcNowPlayingMovies);
  }

  void _fethcNowPlayingMovies(FetchNowPlaying event, Emitter<MoviesPlayingState> emit) async {
    (event.nextPage != null && event.nextPage!) ? _pageCount++ : _pageCount = 1;
    _pageCount == 1 ? _moviesList.clear() : null;
    final List<Movie> list = await _movieRepo.getNowPlayingMovies(page: _pageCount);
    _moviesList.addAll(list);
    emit(MoviesPlayingLoaded(_moviesList));
  }
}
