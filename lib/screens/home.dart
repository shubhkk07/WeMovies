import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/Blocs/MoviesBloc/movies_playing_bloc.dart';
import 'package:movieapp/Blocs/TopRatedmovieBloc/top_rated_movies_bloc.dart';
import 'package:movieapp/Blocs/cubit/location_cubit.dart';
import 'package:movieapp/screens/box_widget.dart';
import 'package:movieapp/screens/custom_clipper.dart';
import 'package:movieapp/screens/movie_image.dart';
import 'package:movieapp/screens/movie_search_delegate.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    BlocProvider.of<LocationCubit>(context, listen: false).checkPermission();
    BlocProvider.of<TopRatedMoviesBloc>(context, listen: false).add(FetchTopRatedMovies());
    BlocProvider.of<MoviesPlayingBloc>(context, listen: false).add(FetchNowPlaying());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var customShapeWidget = ClipPath(
      clipper: BoxClipper(),
      child: Container(
          height: MediaQuery.of(context).size.height * 0.12,
          decoration: BoxDecoration(color: Color.fromARGB(44, 25, 20, 28), borderRadius: BorderRadius.circular(20)),
          padding: const EdgeInsets.only(left: 16, top: 20),
          child:
              const Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              "We Movies",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
            ),
            Text("22 movies are loaded in now playing."),
          ])),
    );

    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
        Color.fromARGB(169, 147, 109, 146),
        Color.fromARGB(196, 182, 146, 179),
        Color.fromARGB(218, 178, 159, 178),
        Color.fromARGB(225, 167, 162, 167),
        Color.fromARGB(241, 240, 240, 255),
        Colors.white
      ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
      child: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 18, vertical: 30),
        child: Column(
          children: [
            appbar,
            const SizedBox(height: 20),
            textField(),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  customShapeWidget,
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Text("NOW PLAYING"),
                      Container(
                        margin: const EdgeInsets.only(left: 20),
                        height: 1,
                        width: MediaQuery.of(context).size.width * 0.5,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [Colors.grey, Colors.grey.withOpacity(0.8), Colors.grey.withOpacity(0.3)])),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.37,
                    child: BlocBuilder<MoviesPlayingBloc, MoviesPlayingState>(builder: (context, state) {
                      if (state is MoviesPlayingLoaded) {
                        return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: state.list.length,
                            itemBuilder: (context, index) {
                              final movie = state.list[index];
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
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20), color: Colors.black.withOpacity(0.5)),
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
                                                    child: const Wrap(
                                                      children: [
                                                        Padding(
                                                          padding: const EdgeInsets.only(top: 2.0),
                                                          child: Icon(
                                                            Icons.place_outlined,
                                                            color: Colors.white,
                                                            size: 14,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 2,
                                                        ),
                                                        Text(
                                                          "English",
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
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 2,
                                            ),
                                            Row(
                                              children: [
                                                Icon(
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
                                              style: TextStyle(color: Colors.white),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              );
                            });
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    }),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.black),
                        child: Text(
                          '1/22',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(color: Colors.black, shape: BoxShape.circle),
                        height: 10,
                        width: 10,
                      ),
                      Container(
                        decoration: const BoxDecoration(color: Colors.black, shape: BoxShape.circle),
                        height: 10,
                        width: 10,
                      )
                    ],
                  ),

                  const SizedBox(height: 20),

                  //TOP Rated
                  Row(
                    children: [
                      Text("TOP RATED"),
                      Container(
                        margin: const EdgeInsets.only(left: 20),
                        height: 1,
                        width: MediaQuery.of(context).size.width * 0.5,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                          Colors.grey.withOpacity(0.6),
                          Colors.grey.withOpacity(0.4),
                          Colors.grey.withOpacity(0.1)
                        ])),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  BlocBuilder<TopRatedMoviesBloc, TopRatedMoviesState>(
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
                                            borderRadius: BorderRadius.all(Radius.circular(16)),
                                            child: MovieImage(
                                              size: Size(MediaQuery.of(context).size.width * 0.75,
                                                  MediaQuery.of(context).size.height * 0.16),
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
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 4,
                                            ),
                                            Row(
                                              children: [
                                                Icon(
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
                                                    style: TextStyle(fontSize: 10),
                                                  ),
                                                )
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 4,
                                            ),
                                            Text("${movie.voteCount} Votes | ${movie.voteAverage}")
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
                        return Text("");
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }

  var appbar = Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
        flex: 3,
        child: BlocConsumer<LocationCubit, LocationState>(listener: (context, state) {
          if (state is LocationRequestState) {
            context.read<LocationCubit>().requestPermission();
          }
        }, builder: (context, state) {
          if (state is LocationLoaded) {
            print(state.locationDetails);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  children: [
                    const Icon(Icons.place_outlined),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(state.locationDetails.locality ?? "", style: Theme.of(context).textTheme.bodyLarge)
                  ],
                ),
                Text(
                  ("${state.locationDetails.street ?? ""}, ${state.locationDetails.subAdministrativeArea ?? ""}, ${state.locationDetails.administrativeArea ?? ""}"),
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(color: Colors.black.withOpacity(0.7)),
                ),
              ],
            );
          } else {
            return const SizedBox();
          }
        }),
      ),
      Expanded(
        flex: 1,
        child: Container(
          alignment: Alignment.centerRight,
          child: const CircleAvatar(
            backgroundImage: AssetImage('images/a.png'),
          ),
        ),
      )
    ],
  );

  Widget textField() => TextField(
        onTap: () {
          showSearch(context: context, delegate: MovieSearchDelegate());
        },
        readOnly: true,
        canRequestFocus: false,
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            labelText: "Search Movies by name...",
            prefixIcon: const Icon(Icons.search),
            enabledBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: Colors.white))),
      );
}
