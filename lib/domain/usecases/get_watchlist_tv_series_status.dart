import 'package:ditonton/domain/repositories/tv_series_repository.dart';

class GetWatchListTvSeriesStatus {
  final TVSeriesRepository repository;

  GetWatchListTvSeriesStatus(this.repository);

  Future<bool> execute(int id) async {
    return repository.isAddedToWatchlist(id);
  }
}
