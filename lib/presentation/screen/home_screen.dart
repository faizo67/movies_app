import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/presentation/bloc/movies/popular_movies/popular_movies_bloc.dart';
import 'package:movies_app/presentation/bloc/movies/popular_movies/popular_movies_state.dart';
import 'package:movies_app/presentation/bloc/movies/trending_movies/trending_movies_bloc.dart';
import 'package:movies_app/presentation/bloc/movies/trending_movies/trending_movies_state.dart';
import 'package:movies_app/presentation/screen/movies_list.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
        toolbarHeight: 50.h,
        backgroundColor: const Color.fromARGB(255, 4, 25, 65),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Movie App',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: EdgeInsets.all(20.r),
            child: const Icon(Icons.search),
          ),
        ],
      ),
      body: Container(
        color: Colors.black,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              mainImageBuilder(),
              SizedBox(height: 10.h),

              // Trending Movies Header
              Center(
                child: Text(
                  'Trending Movies',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              trendingMoviesBuilder(),
              SizedBox(height: 20.h),

              // Popular Movies Header
              Center(
                child: Text(
                  'Popular Movies',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
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
          return const Center(child: CircularProgressIndicator());
        } else if (state is PopularMoviesLoad) {
          return MoviesList(movies: state.movies);
        } else if (state is PopularMoviesError) {
          return Text(
            state.error,
            style: TextStyle(color: Colors.red, fontSize: 14.sp),
          );
        }
        return SizedBox(height: 50.h);
      },
    );
  }

  BlocBuilder<PopularMoviesBloc, PopularMoviesState> mainImageBuilder() {
    return BlocBuilder<PopularMoviesBloc, PopularMoviesState>(
      builder: (context, state) {
        if (state is PopularMoviesLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is PopularMoviesLoad && state.movies.isNotEmpty) {
          return CarouselSlider.builder(
            itemCount: state.movies.length,
            itemBuilder: (context, index, realIndex) {
              final movies = state.movies[index];
              return Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  height: 250.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20.r),
                      bottomRight: Radius.circular(20.r),
                      topLeft: Radius.circular(10.r),
                      topRight: Radius.circular(10.r),
                    ),
                    image: DecorationImage(
                      image: NetworkImage(
                        'https://image.tmdb.org/t/p/w500/${movies.posterPath}',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
            options: CarouselOptions(height: 200.h),
          );
        } else if (state is PopularMoviesError) {
          return Text(
            state.error,
            style: TextStyle(color: Colors.red, fontSize: 14.sp),
          );
        }
        return SizedBox(height: 250.h);
      },
    );
  }

  BlocBuilder<TrendingMoviesBloc, TrendingMoviesState> trendingMoviesBuilder() {
    return BlocBuilder<TrendingMoviesBloc, TrendingMoviesState>(
      builder: (context, state) {
        if (state is TrendingMoviesLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is TrendingMoviesLoad) {
          return MoviesList(movies: state.movies);
        } else if (state is TrendingMoviesError) {
          return Text(
            state.faliure,
            style: TextStyle(color: Colors.red, fontSize: 14.sp),
          );
        }
        return SizedBox(height: 50.h);
      },
    );
  }
}
