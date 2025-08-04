import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/domain/usecase/get_trending_movie_usecase.dart';
import 'package:movies_app/presentation/bloc/movies/trending_movies/trending_movies_event.dart';
import 'package:movies_app/presentation/bloc/movies/trending_movies/trending_movies_state.dart';

class TrendingMoviesBloc
    extends Bloc<TrendingMoviesEvent, TrendingMoviesState> {
  final GetTrendingMovieUsecase getTrendingMovieUsecase;

  TrendingMoviesBloc({required this.getTrendingMovieUsecase})
    : super(TrendingMoviesInitial()) {
    on<FetchTrendingMoviesEvent>((event, emit) async {
      emit(TrendingMoviesLoading());

      final faliureOrMovies = await getTrendingMovieUsecase();
      faliureOrMovies.fold(
        (failure) => emit(TrendingMoviesError(failure.toString())),
        (movies) => emit(TrendingMoviesLoad(movies)),
      );
    });
  }
}
