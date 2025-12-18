import 'package:dartz/dartz.dart';
import 'package:core/common/failure.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/domain/repository/tv_series_repository.dart';

class GetWatchlistTvSeries {
  final TVSeriesRepository _repository;

  GetWatchlistTvSeries(this._repository);

  Future<Either<Failure, List<TVSeries>>> execute() {
    return _repository.getWatchlistTvSeries();
  }
}
