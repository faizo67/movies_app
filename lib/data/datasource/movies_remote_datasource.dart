import 'package:movies_app/data/models/movie_model.dart';

abstract class MoviesRemoteDatasource {
  Future<List<MovieModel>> getTrendingMovies();
  Future<List<MovieModel>> searchMovies(String query);
  Future<List<MovieModel>> getPopularMovies();
}
