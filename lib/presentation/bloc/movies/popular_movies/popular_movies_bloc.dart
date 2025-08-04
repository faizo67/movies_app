import 'package:bloc/bloc.dart';
import 'package:movies_app/domain/usecase/get_popular_movie_usecase.dart';
import 'package:movies_app/presentation/bloc/movies/popular_movies/popular_movies_event.dart';
import 'package:movies_app/presentation/bloc/movies/popular_movies/popular_movies_state.dart';

class PopularMoviesBloc extends Bloc<PopularMoviesEvent, PopularMoviesState> {
  GetPopularMovieUsecase getPopularMovieUsecase;
  PopularMoviesBloc({required this.getPopularMovieUsecase})
    : super(PopularMoviesInitail()) {
    on<FetchPopularMoviesEvent>((event, emit) async {
      emit(PopularMoviesInitail());
      final faliureOrMovies = await getPopularMovieUsecase();
      faliureOrMovies.fold(
        (faliure) => emit(PopularMoviesError(faliure.toString())),
        (movies) => emit(PopularMoviesLoad(movies)),
      );
    });
  }
}
