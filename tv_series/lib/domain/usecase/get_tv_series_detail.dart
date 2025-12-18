import 'package:dartz/dartz.dart';
import 'package:core/common/failure.dart';
import 'package:tv_series/domain/entities/tv_series_detail.dart';
import 'package:tv_series/domain/repository/tv_series_repository.dart';

class GetTvSeriesDetail {
  final TVSeriesRepository repository;

  GetTvSeriesDetail(this.repository);

  Future<Either<Failure, TvSeriesDetail>> execute(int id) {
    return repository.getTvSeriesDetail(id);
  }
}
