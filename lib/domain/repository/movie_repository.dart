import 'package:dartz/dartz.dart';
import 'package:movies_app/core/error/server_faliure.dart';
import 'package:movies_app/domain/entity/movie_entity.dart';

abstract class MovieRepository {
  Future<Either<Failure, List<MovieEntity>>> getTrendingMovies();
  Future<Either<Failure, List<MovieEntity>>> searchMovies(String query);
  Future<Either<Failure, List<MovieEntity>>> getPopularMovies();
}
