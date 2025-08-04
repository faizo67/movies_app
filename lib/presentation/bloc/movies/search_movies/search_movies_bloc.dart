import 'package:bloc/bloc.dart';
import 'package:movies_app/domain/usecase/search_movie_usecase.dart';
import 'package:movies_app/presentation/bloc/movies/search_movies/search_movies_event.dart';
import 'package:movies_app/presentation/bloc/movies/search_movies/search_movies_state.dart';

class SearchMoviesBloc extends Bloc<SearchMoviesEvent, SearchMoviesState> {
  SearchMovieUsecase searchMovieUsecase;
  SearchMoviesBloc({required this.searchMovieUsecase})
    : super(SearchMoviesInitialState()) {
    on<FetchSearchMoviesEvent>((event, emit) async {
      emit(SearchMoviesLoadingState());

      final folderOnMovies = await searchMovieUsecase(event.toString());

      folderOnMovies.fold(
        (failure) => emit(SearchMoviesErrorState()),
        (movies) => emit(SearchMoviesLoadState(movies)),
      );
    });
  }
}
