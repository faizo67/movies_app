import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:movies_app/data/datasource/movies_remote_datasource.dart';
import 'package:movies_app/data/datasource/remote/movies_remote_datasource_impl.dart';
import 'package:movies_app/data/repository/movies/movies_repository_impl.dart';
import 'package:movies_app/domain/repository/movie_repository.dart';
import 'package:movies_app/domain/usecase/get_popular_movie_usecase.dart';
import 'package:movies_app/domain/usecase/get_trending_movie_usecase.dart';
import 'package:movies_app/domain/usecase/search_movie_usecase.dart';
import 'package:movies_app/presentation/bloc/movies/popular_movies/popular_movies_bloc.dart';
import 'package:movies_app/presentation/bloc/movies/search_movies/search_movies_bloc.dart';
import 'package:movies_app/presentation/bloc/movies/trending_movies/trending_movies_bloc.dart';

final getIt = GetIt.instance;

void init() {
  // Bloc
  getIt.registerFactory(
    () => PopularMoviesBloc(getPopularMovieUsecase: getIt()),
  );
  getIt.registerFactory(
    () => TrendingMoviesBloc(getTrendingMovieUsecase: getIt()),
  );
  getIt.registerFactory(() => SearchMoviesBloc(searchMovieUsecase: getIt()));

  // Use cases
  getIt.registerLazySingleton(() => GetPopularMovieUsecase(getIt()));
  getIt.registerLazySingleton(() => GetTrendingMovieUsecase(getIt()));
  getIt.registerLazySingleton(() => SearchMovieUsecase(getIt()));

  // Repositories
  getIt.registerLazySingleton<MovieRepository>(
    () => MoviesRepositoryImpl(datasource: getIt()),
  );

  // Data sources
  getIt.registerLazySingleton<MoviesRemoteDatasource>(
    () => MoviesRemoteDatasourceImpl(client: getIt()),
  );

  // Http service
  getIt.registerLazySingleton(() => http.Client());
}
