import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/Blocs/MoviesBloc/movies_playing_bloc.dart';
import 'package:movieapp/Blocs/TopRatedmovieBloc/top_rated_movies_bloc.dart';
import 'package:movieapp/Models/movies.dart';

class MovieSearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back_ios));
  }

  @override
  Widget buildResults(BuildContext context) {
    final moviesList =
        BlocProvider.of<TopRatedMoviesBloc>(context).movieList + BlocProvider.of<MoviesPlayingBloc>(context).nowPlayingMovies;

    final List<Movie> filteredMovies = [];

    for (var movie in moviesList) {
      if (movie.originalTitle!.toLowerCase().contains(query.toLowerCase())) {
        filteredMovies.add(movie);
      }
    }

    return ListView.builder(
        itemCount: filteredMovies.length,
        itemBuilder: (context, index) {
          return ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage("https://image.tmdb.org/t/p/w500${filteredMovies[index].backdropPath}"),
              ),
              title: Text(
                filteredMovies[index].originalTitle ?? "",
                style: TextStyle(fontWeight: FontWeight.w600),
              ));
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final moviesList =
        BlocProvider.of<TopRatedMoviesBloc>(context).movieList + BlocProvider.of<MoviesPlayingBloc>(context).nowPlayingMovies;

    final List<Movie> filteredMovies = [];

    for (var movie in moviesList) {
      if (movie.originalTitle!.toLowerCase().contains(query.toLowerCase())) {
        filteredMovies.add(movie);
      }
    }

    if (query.isNotEmpty) {
      if (filteredMovies.isNotEmpty) {
        return ListView.builder(
            itemCount: filteredMovies.length,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.withOpacity(0.1)))),
                padding: const EdgeInsets.only(bottom: 10.0),
                child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage("https://image.tmdb.org/t/p/w500${filteredMovies[index].backdropPath}"),
                    ),
                    title: Text(
                      filteredMovies[index].originalTitle ?? "",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    )),
              );
            });
      } else {
        return const Center(
          child: Text("No Results Found"),
        );
      }
    } else {
      return const SizedBox();
    }
  }
}
