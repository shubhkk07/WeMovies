import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:movieapp/Blocs/MoviesBloc/movies_playing_bloc.dart';
import 'package:movieapp/Blocs/TopRatedmovieBloc/top_rated_movies_bloc.dart';
import 'package:movieapp/Blocs/cubit/location_cubit.dart';
import 'package:movieapp/extensions/Date.dart';
import 'package:movieapp/extensions/int.dart';
import 'package:movieapp/screens/box_widget.dart';
import 'package:movieapp/screens/custom_clipper.dart';
import 'package:movieapp/screens/movie_image.dart';
import 'package:movieapp/screens/movie_search_delegate.dart';
import 'package:movieapp/screens/now_playing_movies.dart';
import 'package:movieapp/screens/top_rated_movies.dart';

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
    var customShapeWidget = Stack(
      children: [
        ClipPath(
          clipper: BoxClipper(),
          child: Container(
              height: MediaQuery.of(context).size.height * 0.12,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: const Color.fromARGB(44, 25, 20, 28), borderRadius: BorderRadius.circular(20)),
              padding: const EdgeInsets.only(left: 16, top: 20),
              child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text(
                  "We Movies",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                ),
                Text("22 movies are loaded in now playing."),
              ])),
        ),
        Positioned(
          left: 20,
          child: Text(
            DateTime.now().convertDateTime(),
          ),
        ),
      ],
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
        child: RefreshIndicator(
          onRefresh: () async {
            BlocProvider.of<TopRatedMoviesBloc>(context, listen: false).add(FetchTopRatedMovies());
            BlocProvider.of<MoviesPlayingBloc>(context, listen: false).add(FetchNowPlaying());
            return;
          },
          child: Column(
            children: [
              //APPBAR
              appbar,
              const SizedBox(height: 20),

              //Search Field
              textField(),
              const SizedBox(height: 20),

              //
              Expanded(
                child: NotificationListener(
                  onNotification: (notification) {
                    if (notification is ScrollEndNotification && notification.metrics.extentAfter == 0) {
                      BlocProvider.of<TopRatedMoviesBloc>(context).add(FetchTopRatedMovies(nextPage: true));
                    }
                    return false;
                  },
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
                      const NowPlayingMovies(),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
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

                      const TopRatedMovies(),
                    ],
                  ),
                ),
              ),
            ],
          ),
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
