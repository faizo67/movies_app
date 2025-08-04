import 'package:flutter/material.dart';
import 'package:movies_app/domain/entity/movie_entity.dart';

class DetailScreen extends StatelessWidget {
  final MovieEntity movie;
  const DetailScreen({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text(movie.title)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Images of this Movie
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Hero(
                tag: movie.id, // Must be exactly same tag
                child: Ink.image(
                  image: NetworkImage(
                    'https://image.tmdb.org/t/p/w500/${movie.posterPath}',
                  ),
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),
            // title
            Text(
              movie.title,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 20),
            // description and overView
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                movie.overview,
                style: TextStyle(color: Colors.white54),
              ),
            ),

            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20), // Border radius
                ),
              ),
              child: Text('▶️ Watch the Full Movie Here'),
            ),
          ],
        ),
      ),
    );
  }
}
