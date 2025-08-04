import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/injection_container.dart';
import 'package:movies_app/presentation/bloc/movies/popular_movies/popular_movies_bloc.dart';
import 'package:movies_app/presentation/bloc/movies/popular_movies/popular_movies_event.dart';
import 'package:movies_app/presentation/bloc/movies/search_movies/search_movies_bloc.dart';
import 'package:movies_app/presentation/bloc/movies/trending_movies/trending_movies_bloc.dart';
import 'package:movies_app/presentation/bloc/movies/trending_movies/trending_movies_event.dart';
import 'package:movies_app/presentation/screen/home_screen.dart';

void main() {
  init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie App',
      debugShowCheckedModeBanner: false,
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                getIt<PopularMoviesBloc>()..add(FetchPopularMoviesEvent()),
          ),
          BlocProvider(
            create: (context) =>
                getIt<TrendingMoviesBloc>()..add(FetchTrendingMoviesEvent()),
          ),
          BlocProvider(create: (context) => getIt<SearchMoviesBloc>()),
        ],
        child: const HomeScreen(),
      ),
    );
  }
}
