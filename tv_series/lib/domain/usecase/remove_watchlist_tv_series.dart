import 'package:dartz/dartz.dart';
import 'package:core/common/failure.dart';
import 'package:tv_series/domain/entities/tv_series_detail.dart';
import 'package:tv_series/domain/repository/tv_series_repository.dart';

class RemoveTvSeriesWatchlist {
  final TVSeriesRepository repository;

  RemoveTvSeriesWatchlist(this.repository);

  Future<Either<Failure, String>> execute(TvSeriesDetail tvSeries) {
    return repository.removeTvSeriesWatchlist(tvSeries);
  }
}
