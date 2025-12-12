import 'package:ditonton/domain/entities/genre.dart';
import 'package:equatable/equatable.dart';

class TvSeriesDetail extends Equatable {
  TvSeriesDetail({
    required this.adult,
    required this.backdropPath,
    required this.genres,
    required this.id,
    required this.originalName,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.firstAirDate,
    required this.lastAirDate,
    required this.voteAverage,
    required this.voteCount,
    // required this.numberOfEpisodes,
    // required this.numberOfSeasons,
  });

  final bool adult;
  final String? backdropPath;
  final List<Genre> genres;
  final int id;
  final String originalName;
  final String name;
  final String overview;
  final String posterPath;
  final String firstAirDate;
  final String lastAirDate;
  final double voteAverage;
  final int voteCount;

  // final int numberOfEpisodes;
  // final int numberOfSeasons;
  // final List<int> episodeRunTime;
  // List<Season> seasons;
  // EpisodeSeries lastEpisodeToAir
  // EpisodeSeries nextEpisodeToAir

  @override
  List<Object?> get props => [
    adult,
    backdropPath,
    genres,
    id,
    originalName,
    name,
    overview,
    posterPath,
    firstAirDate,
    lastAirDate,
    // numberOfEpisodes,
    // numberOfSeasons,
    voteAverage,
    voteCount,
  ];
}
