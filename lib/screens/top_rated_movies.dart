import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/Blocs/TopRatedmovieBloc/top_rated_movies_bloc.dart';
import 'package:movieapp/extensions/double.dart';
import 'package:movieapp/screens/movie_image.dart';

class TopRatedMovies extends StatelessWidget {
  const TopRatedMovies({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TopRatedMoviesBloc, TopRatedMoviesState>(
      builder: (context, state) {
        if (state is TopRatedMoviesLoaded) {
          return Column(
            children: List.generate(state.topRatedMovies.length, (index) {
              final movie = state.topRatedMovies[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Material(
                  shadowColor: Colors.grey,
                  borderRadius: BorderRadius.circular(20),
                  elevation: 5,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.75,
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.white),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.all(Radius.circular(16)),
                              child: MovieImage(
                                size: Size(MediaQuery.of(context).size.width * 0.75, MediaQuery.of(context).size.height * 0.16),
                                imagePath: movie.backdropPath ?? "",
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                movie.originalTitle ?? "",
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.calendar_today,
                                    size: 12,
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.6,
                                    child: Text(
                                      movie.overview ?? "",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(fontSize: 10),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Wrap(
                                children: [
                                  Text("${movie.voteCount!.covertInKM()} Votes | ${movie.voteAverage!.toStringAsFixed(2)}"),
                                  const Padding(
                                    padding: EdgeInsets.only(left: 2.0),
                                    child: Icon(
                                      Icons.star,
                                      color: Color(0xffFFD700),
                                      size: 20,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
