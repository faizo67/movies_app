import 'package:flutter/material.dart';
import 'package:movies_app/domain/entity/movie_entity.dart';
import 'package:movies_app/presentation/screen/detail_screen.dart';

class MovieCard extends StatelessWidget {
  const MovieCard(this.movie, {super.key});

  final MovieEntity movie;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: InkWell(
        onTap: () {
          // TODO: Navigate to detail screen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DetailScreen(movie: movie)),
          );
        },
        child: Stack(
          children: [
            // Background Movie Image
            Hero(
              tag: movie.id,
              flightShuttleBuilder:
                  (
                    flightContext,
                    animation,
                    flightDirection,
                    fromHeroContext,
                    toHeroContext,
                  ) {
                    return RotationTransition(
                      turns: animation.drive(
                        Tween<double>(
                          begin: 0.0,
                          end: 1.0,
                        ).chain(CurveTween(curve: Curves.easeInOut)),
                      ),
                      child: ScaleTransition(
                        scale: animation.drive(
                          Tween<double>(
                            begin: 0.8,
                            end: 1.0,
                          ).chain(CurveTween(curve: Curves.easeOut)),
                        ),
                        child: FadeTransition(
                          opacity: animation,
                          child: toHeroContext.widget,
                        ),
                      ),
                    );
                  },
              child: Ink.image(
                image: NetworkImage(
                  'https://image.tmdb.org/t/p/w500/${movie.posterPath}',
                ),
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            // Gradient Overlay (top to bottom)
            Container(
              height: 250,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                ),
              ),
            ),

            // Movie Title at Bottom Center
            Positioned(
              bottom: 10,
              left: 10,
              right: 10,
              child: Text(
                movie.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      blurRadius: 6,
                      color: Colors.black87,
                      offset: Offset(1, 1),
                    ),
                  ],
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
