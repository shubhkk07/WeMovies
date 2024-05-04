import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/Models/movies.dart';
import 'package:movieapp/Repositoy/movie_repo.dart';

part 'top_rated_movies_event.dart';
part 'top_rated_movies_state.dart';

class TopRatedMoviesBloc extends Bloc<TopRatedMoviesEvent, TopRatedMoviesState> {
  final List<Movie> _movies = [];

  int _pageCount = 1;

  List<Movie> get movieList => _movies;

  final _moviesRepo = MovieRepo();

  TopRatedMoviesBloc() : super(TopRatedMoviesInitial()) {
    on<FetchTopRatedMovies>(_fetchTopRatedMovies);
  }

  void _fetchTopRatedMovies(FetchTopRatedMovies event, Emitter<TopRatedMoviesState> emit) async {
    (event.nextPage != null && event.nextPage!) ? _pageCount++ : _pageCount = 1;
    final List<Movie> moviesList = await _moviesRepo.getTopRatedMovies(page: _pageCount);
    _movies.addAll(moviesList);
    emit(TopRatedMoviesLoaded(topRatedMovies: _movies));
  }
}
