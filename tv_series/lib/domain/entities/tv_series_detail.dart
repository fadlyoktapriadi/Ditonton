
import 'package:equatable/equatable.dart';
import 'package:movie/domain/entities/genre.dart';

class TvSeriesDetail extends Equatable {
  TvSeriesDetail({
    required this.adult,
    required this.backdropPath,
    required this.genres,
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.firstAirDate,
    required this.lastAirDate,
    required this.voteAverage,
    required this.voteCount,
  });

  final bool adult;
  final String? backdropPath;
  final List<Genre> genres;
  final int id;
  final String name;
  final String overview;
  final String posterPath;
  final String firstAirDate;
  final String lastAirDate;
  final double voteAverage;
  final int voteCount;

  @override
  List<Object?> get props => [
    adult,
    backdropPath,
    genres,
    id,
    name,
    overview,
    posterPath,
    firstAirDate,
    lastAirDate,
    voteAverage,
    voteCount,
  ];
}
