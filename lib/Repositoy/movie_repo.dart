import 'package:dio/dio.dart';
import 'package:movieapp/Models/movies.dart';

const String _apiToken =
    "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI2YTg3ZTY4MDMyODIwMTIzZmQ0Yzg0YjQzNDhjYjc3ZCIsInN1YiI6IjY2Mjg5NDExOTFmMGVhMDE0YjAwOWU1ZSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.6zIM73Giwg5M4wP6MX8KDCpee7IMnpnLTZUyMpETb08";

class MovieRepo {
  final _dio = Dio(BaseOptions(baseUrl: "https://api.themoviedb.org/3/movie", headers: {"Authorization": "Bearer $_apiToken"}));

  Future getNowPlayingMovies({int page = 1}) async {
    try {
      final Response response = await _dio.get(
        "/now_playing?language=en-US&page=$page",
      );
      if (response.statusCode == 200) {
        final result = response.data;
        final List<dynamic> movies = result["results"];
        List<Movie> nowPlayingMovies = movies.map((e) => Movie.fromJson(e)).toList();
        return nowPlayingMovies;
      } else {
        return null;
      }
    } on DioException catch (e) {
      print(e.type);
      throw e.toString();
    }
  }

  Future getTopRatedMovies({int page = 1}) async {
    try {
      final Response response = await _dio.get(
        "/top_rated?language=en-US&page=$page",
      );
      if (response.statusCode == 200) {
        final result = response.data;
        final List<dynamic> movies = result["results"];
        List<Movie> nowPlayingMovies = movies.map((e) => Movie.fromJson(e)).toList();
        return nowPlayingMovies;
      } else {
        return null;
      }
    } on DioException catch (e) {
      print(e.type);
      throw e.toString();
    }
  }
}
