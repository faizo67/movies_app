import 'package:movies_app/domain/entity/movie_entity.dart';

abstract class SearchMoviesState {}

class SearchMoviesInitialState extends SearchMoviesState {}

class SearchMoviesLoadingState extends SearchMoviesState {}

class SearchMoviesLoadState extends SearchMoviesState {
  List<MovieEntity> query;
  SearchMoviesLoadState(this.query);
}

class SearchMoviesErrorState extends SearchMoviesState {}
