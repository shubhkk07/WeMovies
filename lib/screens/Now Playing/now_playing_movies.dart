import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:movieapp/Blocs/MoviesBloc/movies_playing_bloc.dart';
import 'package:movieapp/screens/Components/custom_clipper.dart';
import 'package:movieapp/screens/Movie%20Item/movie_image.dart';
import 'package:movieapp/screens/Now%20Playing/now_playing_movies_index.dart';

class NowPlayingMovies extends StatefulWidget {
  const NowPlayingMovies({super.key});

  @override
  State<NowPlayingMovies> createState() => _NowPlayingMoviesState();
}

class _NowPlayingMoviesState extends State<NowPlayingMovies> {
  final ScrollController controller = ScrollController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.39,
      child: BlocBuilder<MoviesPlayingBloc, MoviesPlayingState>(builder: (context, state) {
        if (state is MoviesPlayingLoaded) {
          return NotificationListener(
            onNotification: (notification) {
              if (notification is ScrollEndNotification && notification.metrics.extentAfter == 0) {
                BlocProvider.of<MoviesPlayingBloc>(context).add(FetchNowPlaying(nextPage: true));
              }
              return false;
            },
            child: Column(children: [
              Expanded(
                child: ListView.builder(
                    controller: controller,
                    scrollDirection: Axis.horizontal,
                    itemCount: state.list.length,
                    itemExtent: MediaQuery.of(context).size.width * 0.7,
                    itemBuilder: (context, index) {
                      final movie = state.list[index];

                      //method call set selected
                      return Stack(
                        children: [
                          ClipPath(
                              clipper: CustomShapeClipper(),
                              child: Padding(
                                  padding: const EdgeInsets.only(right: 20.0),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: MovieImage(
                                        imagePath: movie.backdropPath ?? "",
                                        size: Size(
                                          MediaQuery.of(context).size.width * 0.65,
                                          MediaQuery.of(context).size.height * 0.35,
                                        ),
                                      )))),
                          Positioned(
                            top: MediaQuery.of(context).size.height * 0.2,
                            child: ClipPath(
                              clipper: CustomShapeClipper(height: 0.2, width: 0.4),
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                decoration:
                                    BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.black.withOpacity(0.5)),
                                margin: const EdgeInsets.only(right: 20),
                                height: MediaQuery.of(context).size.height * 0.15,
                                width: MediaQuery.of(context).size.width * 0.65,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                            alignment: Alignment.topLeft,
                                            width: MediaQuery.of(context).size.width * 0.27,
                                            child: Wrap(
                                              children: [
                                                const Padding(
                                                  padding: EdgeInsets.only(top: 2.0),
                                                  child: Icon(
                                                    Icons.place_outlined,
                                                    color: Colors.white,
                                                    size: 14,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 2,
                                                ),
                                                Text(
                                                  LocaleNames.of(context)?.nameOf(movie.originalLanguage ?? "en") ??
                                                      "".toString(),
                                                  style: TextStyle(color: Colors.white, fontSize: 12),
                                                )
                                              ],
                                            ))
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      movie.originalTitle ?? "",
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.calendar_month_rounded,
                                          color: Colors.white,
                                          size: 12,
                                        ),
                                        const SizedBox(
                                          width: 6,
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context).size.width * 0.48,
                                          child: Text(
                                            movie.overview ?? "",
                                            maxLines: 2,
                                            softWrap: true,
                                            style: const TextStyle(color: Colors.white, fontSize: 11),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      "${movie.voteCount} Votes",
                                      style: const TextStyle(color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                              top: 8,
                              right: 30,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(right: 4),
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.5), borderRadius: BorderRadius.circular(20)),
                                    child: Wrap(
                                      children: [
                                        const Icon(
                                          Icons.remove_red_eye_outlined,
                                          color: Colors.white,
                                          size: 16,
                                        ),
                                        const SizedBox(
                                          width: 3,
                                        ),
                                        Text(
                                          movie.voteCount.toString(),
                                          style: const TextStyle(color: Colors.white, fontSize: 12),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.black.withOpacity(0.5)),
                                    child: const Icon(
                                      Icons.favorite_border_outlined,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                  )
                                ],
                              )),
                          Positioned(
                              top: 2,
                              left: MediaQuery.of(context).size.width * 0.12,
                              child: Wrap(
                                crossAxisAlignment: WrapCrossAlignment.start,
                                children: [
                                  Text(
                                    movie.voteAverage!.toStringAsFixed(2),
                                    style: const TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(left: 4.0),
                                    child: Icon(
                                      Icons.star,
                                      color: Color(0xffFFD700),
                                      size: 16,
                                    ),
                                  )
                                ],
                              )),
                        ],
                      );
                    }),
              ),
              NowPlayingIndex(moviesLength: state.list.length, scrollController: controller)
            ]),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      }),
    );
  }
}
