import 'dart:convert';

import 'package:movies_app/core/error/service_exception.dart';
import 'package:movies_app/data/datasource/movies_remote_datasource.dart';

import 'package:http/http.dart' as https;
import 'package:movies_app/data/models/movie_model.dart';

class MoviesRemoteDatasourceImpl extends MoviesRemoteDatasource {
  late https.Client client;
  MoviesRemoteDatasourceImpl({required this.client});

  static const BASE_URL = "https://api.themoviedb.org/3";
  static const API_KEY = "feefd9dfdbae7ed0a59490812ba90ad8";

  @override
  Future<List<MovieModel>> getPopularMovies() async {
    final response = await client.get(
      Uri.parse("$BASE_URL/movie/popular?api_key=$API_KEY"),
    );

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      final List<MovieModel> getPopularMovies =
          (responseBody['results'] as List)
              .map((movies) => MovieModel.fromJson(movies))
              .toList();
      return getPopularMovies;
    } else {
      throw ServiceException();
    }
  }

  @override
  Future<List<MovieModel>> getTrendingMovies() async {
    final response = await client.get(
      Uri.parse("$BASE_URL/trending/movie/day?api_key=$API_KEY"),
    );

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      final List<MovieModel> getTrendingMovies =
          (responseBody['results'] as List)
              .map((movies) => MovieModel.fromJson(movies))
              .toList();
      return getTrendingMovies;
    } else {
      throw ServiceException();
    }
  }

  @override
  Future<List<MovieModel>> searchMovies(String query) async {
    final response = await client.get(
      Uri.parse("$BASE_URL/search/movie?query=$query&api_key=$API_KEY"),
    );

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      final List<MovieModel> searchMovies = (responseBody['results'] as List)
          .map((movies) => MovieModel.fromJson(movies))
          .toList();
      return searchMovies;
    } else {
      throw ServiceException();
    }
  }
}
