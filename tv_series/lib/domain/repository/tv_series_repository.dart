import 'package:dartz/dartz.dart';
import 'package:core/common/failure.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/domain/entities/tv_series_detail.dart';

abstract class TVSeriesRepository {
  Future<Either<Failure, List<TVSeries>>> getNowPlayingTVSeries();
  Future<Either<Failure, List<TVSeries>>> getPopularTvSeries();
  Future<Either<Failure, List<TVSeries>>> getTopRatedTvSeries();
  Future<Either<Failure, TvSeriesDetail>> getTvSeriesDetail(int id);
  Future<Either<Failure, List<TVSeries>>> getTvSeriesRecommendations(int id);
  Future<Either<Failure, List<TVSeries>>> searchTvSeries(String query);
  Future<Either<Failure, String>> saveTvSeriesWatchlist(TvSeriesDetail movie);
  Future<Either<Failure, String>> removeTvSeriesWatchlist(TvSeriesDetail movie);
  Future<bool> isAddedToWatchlist(int id);
  Future<Either<Failure, List<TVSeries>>> getWatchlistTvSeries();
}
