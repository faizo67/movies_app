import 'package:movies_app/domain/entity/movie_entity.dart';

abstract class TrendingMoviesState {}

class TrendingMoviesInitial extends TrendingMoviesState {}

class TrendingMoviesLoading extends TrendingMoviesState {}

class TrendingMoviesLoad extends TrendingMoviesState {
  List<MovieEntity> movies;
  TrendingMoviesLoad(this.movies);
}

class TrendingMoviesError extends TrendingMoviesState {
  final String faliure;
  TrendingMoviesError(this.faliure);
}
