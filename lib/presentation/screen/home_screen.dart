import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/presentation/bloc/movies/popular_movies/popular_movies_bloc.dart';
import 'package:movies_app/presentation/bloc/movies/popular_movies/popular_movies_state.dart';
import 'package:movies_app/presentation/bloc/movies/trending_movies/trending_movies_bloc.dart';
import 'package:movies_app/presentation/bloc/movies/trending_movies/trending_movies_state.dart';
import 'package:movies_app/presentation/screen/movies_list.dart';
import 'package:movies_app/presentation/widget/movie_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  final bckImage =
      'https://w0.peakpx.com/wallpaper/732/875/HD-wallpaper-anonymous-black-cool-dark-guy-foux-hacker-scary-tech.jpg';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
        toolbarHeight: 50,
        backgroundColor: const Color.fromARGB(255, 4, 25, 65),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Movie App',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        actions: const [
          Padding(padding: EdgeInsets.all(20), child: Icon(Icons.search)),
        ],
      ),
      body: Container(
        color: Colors.black,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Default Image
              mainImageBuilder(),
              const SizedBox(height: 10),
              // Trending Movies
              Center(
                child: const Text(
                  'Trending Movies',

                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // BlocBuilder here
              trendingMoviesBuilder(),

              const SizedBox(height: 20),
              // Popular Movies
              Center(
                child: const Text(
                  'Popular Movies',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Bloc Builder for Popular Movies
              popularMoviesBuilder(),
            ],
          ),
        ),
      ),
    );
  }

  BlocBuilder<PopularMoviesBloc, PopularMoviesState> popularMoviesBuilder() {
    return BlocBuilder<PopularMoviesBloc, PopularMoviesState>(
      builder: (context, state) {
        if (state is PopularMoviesLoading) {
          return const CircularProgressIndicator();
        } else if (state is PopularMoviesLoad) {
          return MoviesList(movies: state.movies);
        } else if (state is PopularMoviesError) {
          return Text(state.error);
        }
        return Container();
      },
    );
  }

  BlocBuilder<PopularMoviesBloc, PopularMoviesState> mainImageBuilder() {
    return BlocBuilder<PopularMoviesBloc, PopularMoviesState>(
      builder: (context, state) {
        if (state is PopularMoviesLoading) {
          return const CircularProgressIndicator();
        } else if (state is PopularMoviesLoad) {
          final posterPath = state.movies.first.posterPath;
          return Container(
            height: 250,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              image: DecorationImage(
                image: NetworkImage(
                  'https://image.tmdb.org/t/p/w500/$posterPath',
                ),
                fit: BoxFit.cover,
              ),
            ),
          );
        } else if (state is PopularMoviesError) {
          return Text(state.error);
        }
        return Container();
      },
    );
  }

  BlocBuilder<TrendingMoviesBloc, TrendingMoviesState> trendingMoviesBuilder() {
    return BlocBuilder<TrendingMoviesBloc, TrendingMoviesState>(
      builder: (context, state) {
        if (state is TrendingMoviesLoading) {
          return const CircularProgressIndicator();
        } else if (state is TrendingMoviesLoad) {
          return MoviesList(movies: state.movies);
        } else if (state is TrendingMoviesError) {
          return Text(state.faliure);
        }
        return Container();
      },
    );
  }
}
