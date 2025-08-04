import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/domain/entity/movie_entity.dart';

class DetailScreen extends StatelessWidget {
  final MovieEntity movie;
  const DetailScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(movie.title, style: TextStyle(fontSize: 18.sp)),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image section
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.r),
                  bottomRight: Radius.circular(20.r),
                ),
              ),
              child: Hero(
                tag: movie.id,
                child: Ink.image(
                  image: NetworkImage(
                    'https://image.tmdb.org/t/p/w500/${movie.posterPath}',
                  ),
                  height: 250.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            SizedBox(height: 20.h),

            // Title
            Center(
              child: Text(
                movie.title,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 22.sp,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            SizedBox(height: 20.h),

            // Overview Text
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Text(
                movie.overview,
                style: TextStyle(color: Colors.white70, fontSize: 14.sp),
              ),
            ),

            SizedBox(height: 20.h),

            // Watch Button
            Center(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.red,
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                    vertical: 12.h,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                ),
                child: Text(
                  '▶️ Watch the Full Movie Here',
                  style: TextStyle(fontSize: 16.sp),
                ),
              ),
            ),

            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
