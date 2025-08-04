import 'package:flutter/material.dart';
import 'package:movies_app/domain/entity/movie_entity.dart';
import 'package:movies_app/presentation/widget/movie_card.dart';

class MoviesList extends StatelessWidget {
  final List<MovieEntity> movies;

  const MoviesList({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: List.generate(movies.length, (index) {
            final movie = movies[index];
            return SizedBox(width: 200, child: MovieCard(movie));
          }),
        ),
      ),
    );
  }
}
