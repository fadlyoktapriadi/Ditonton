import 'package:dartz/dartz.dart';
import 'package:core/common/failure.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/domain/repository/tv_series_repository.dart';

class SearchTvSeries {
  final TVSeriesRepository repository;

  SearchTvSeries(this.repository);

  Future<Either<Failure, List<TVSeries>>> execute(String query) {
    return repository.searchTvSeries(query);
  }
}
