import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:movieapp/Blocs/MoviesBloc/movies_playing_bloc.dart';
import 'package:movieapp/Blocs/TopRatedmovieBloc/top_rated_movies_bloc.dart';
import 'package:movieapp/Blocs/cubit/location_cubit.dart';
import 'package:movieapp/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LocationCubit()),
        BlocProvider(create: (context) => MoviesPlayingBloc()..add(FetchNowPlaying())),
        BlocProvider(create: (context) => TopRatedMoviesBloc()..add(FetchTopRatedMovies())),
      ],
      child: MaterialApp(
        title: 'WeMovie',
        localizationsDelegates: const [
          LocaleNamesLocalizationsDelegate(),
        ],
        home: const SplashScreen(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(useMaterial3: true),
      ),
    );
  }
}
