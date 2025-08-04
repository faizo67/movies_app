import 'package:dartz/dartz.dart';
import 'package:movies_app/core/error/server_faliure.dart';
import 'package:movies_app/core/error/service_exception.dart';
import 'package:movies_app/data/datasource/movies_remote_datasource.dart';
import 'package:movies_app/data/models/movie_model.dart';
import 'package:movies_app/domain/entity/movie_entity.dart';
import 'package:movies_app/domain/repository/movie_repository.dart';

class MoviesRepositoryImpl implements MovieRepository {
  MoviesRemoteDatasource datasource;

  MoviesRepositoryImpl({required this.datasource});
  @override
  Future<Either<Failure, List<MovieEntity>>> getPopularMovies() async {
    try {
      final List<MovieModel> remoteModels = await datasource.getPopularMovies();
      final List<MovieEntity> moviesEntity = remoteModels
          .map((e) => e.toEntity())
          .toList();
      return Right(moviesEntity);
    } on ServiceException {
      return Left(ServerFaliure());
    }
  }

  @override
  Future<Either<Failure, List<MovieEntity>>> getTrendingMovies() async {
    try {
      final List<MovieModel> model = await datasource.getTrendingMovies();
      final List<MovieEntity> moviesEntity = model
          .map((movie) => movie.toEntity())
          .toList();
      return Right(moviesEntity);
    } on ServiceException {
      return Left(ServerFaliure());
    }
  }

  @override
  Future<Either<Failure, List<MovieEntity>>> searchMovies(String query) async {
    try {
      final List<MovieModel> model = await datasource.searchMovies(query);
      final List<MovieEntity> movieEntity = model
          .map((movie) => movie.toEntity())
          .toList();
      return Right(movieEntity);
    } on ServiceException {
      return Left(ServerFaliure());
    }
  }
}
