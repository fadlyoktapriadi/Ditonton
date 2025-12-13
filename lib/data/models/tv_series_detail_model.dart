import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:equatable/equatable.dart';

class TvSeriesDetailResponse extends Equatable {
  TvSeriesDetailResponse({
    required this.adult,
    required this.backdropPath,
    required this.firstAirDate,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.lastAirDate,
    required this.name,
    required this.originalLanguage,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.status,
    required this.tagline,
    required this.voteAverage,
    required this.voteCount,
  });

  final bool adult;
  final String backdropPath;
  final String firstAirDate;
  final List<GenreModel> genres;
  final String homepage;
  final int id;
  final String lastAirDate;
  final String name;
  final String originalLanguage;
  final String overview;
  final double popularity;
  final String posterPath;
  final String status;
  final String tagline;
  final double voteAverage;
  final int voteCount;

  factory TvSeriesDetailResponse.fromJson(Map<String, dynamic> json) =>
      TvSeriesDetailResponse(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        firstAirDate: json["first_air_date"],
        genres: List<GenreModel>.from(json["genres"].map((x) => GenreModel.fromJson(x))),
        homepage: json["homepage"],
        id: json["id"],
        lastAirDate: json["last_air_date"],
        name: json["name"],
        originalLanguage: json["original_language"],
        overview: json["overview"],
        popularity: json["popularity"]?.toDouble(),
        posterPath: json["poster_path"],
        status: json["status"],
        tagline: json["tagline"],
        voteAverage: json["vote_average"]?.toDouble(),
        voteCount: json["vote_count"],
      );

  Map<String, dynamic> toJson() => {
    "adult": adult,
    "backdrop_path": backdropPath,
    "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
    "homepage": homepage,
    "id": id,
    "original_language": originalLanguage,
    "name": name,
    "overview": overview,
    "popularity": popularity,
    "poster_path": posterPath,
    "status": status,
    "tagline": tagline,
    "vote_average": voteAverage,
    "vote_count": voteCount,
  };

  TvSeriesDetail toEntity() {
    return TvSeriesDetail(
      adult: adult,
      backdropPath: backdropPath,
      genres: genres.map((genre) => genre.toEntity()).toList(),
      id: id,
      name: name,
      overview: overview,
      posterPath: posterPath,
      voteAverage: voteAverage,
      voteCount: voteCount,
      firstAirDate: firstAirDate,
      lastAirDate: lastAirDate,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
    adult,
    backdropPath,
    firstAirDate,
    genres,
    homepage,
    id,
    lastAirDate,
    name,
    originalLanguage,
    overview,
    popularity,
    posterPath,
    status,
    tagline,
    voteAverage,
    voteCount,
  ];
}
