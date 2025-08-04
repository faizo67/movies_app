import 'package:movies_app/domain/entity/movie_entity.dart';

abstract class PopularMoviesState {}

class PopularMoviesInitail extends PopularMoviesState {}

class PopularMoviesLoading extends PopularMoviesState {}

class PopularMoviesLoad extends PopularMoviesState {
  List<MovieEntity> movies;
  PopularMoviesLoad(this.movies);
}

class PopularMoviesError extends PopularMoviesState {
  final String error;
  PopularMoviesError(this.error);
}
