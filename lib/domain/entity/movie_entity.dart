import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class MovieEntity extends Equatable {
  int id;
  String title;
  String overview;
  String posterPath;

  MovieEntity({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [id, title, overview, posterPath];
}
