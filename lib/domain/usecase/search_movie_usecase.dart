import 'package:dartz/dartz.dart';
import 'package:movies_app/core/error/server_faliure.dart';
import 'package:movies_app/domain/entity/movie_entity.dart';
import 'package:movies_app/domain/repository/movie_repository.dart';

class SearchMovieUsecase {
  late MovieRepository repository;

  SearchMovieUsecase(this.repository);
  Future<Either<Failure, List<MovieEntity>>> call(String query) async {
    return await repository.searchMovies(query);
  }
}
