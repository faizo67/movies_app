import 'package:flutter/material.dart';
import 'package:movies_app/domain/entity/movie_entity.dart';
import 'package:movies_app/presentation/screen/detail_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MovieCard extends StatelessWidget {
  const MovieCard(this.movie, {super.key});

  final MovieEntity movie;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.all(10.r),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DetailScreen(movie: movie)),
          );
        },
        child: Stack(
          children: [
            // Background Movie Image with Hero
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
                height: 250.h,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            // Gradient Overlay
            Container(
              height: 250.h,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                ),
              ),
            ),

            // Movie Title
            Positioned(
              bottom: 10.h,
              left: 10.w,
              right: 10.w,
              child: Text(
                movie.title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      blurRadius: 6.r,
                      color: Colors.black87,
                      offset: Offset(1.r, 1.r),
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
