import 'package:dartz/dartz.dart';
import 'package:movies_app/core/error/server_faliure.dart';
import 'package:movies_app/domain/entity/movie_entity.dart';
import 'package:movies_app/domain/repository/movie_repository.dart';

class GetPopularMovieUsecase {
  late MovieRepository repository;

  GetPopularMovieUsecase(this.repository);
  Future<Either<Failure, List<MovieEntity>>> call() async {
    return await repository.getPopularMovies();
  }
}
