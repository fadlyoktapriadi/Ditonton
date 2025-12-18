import 'package:core/common/exception.dart';
import 'package:core/data/datasources/local/db/database_helper.dart';
import 'package:core/data/models/tv_series_table.dart';

abstract class TVSeriesLocalDataSource {
  Future<String> insertTvSeriesWatchlist(TVSeriesTable tvSeries);
  Future<String> removeTvSeriesWatchlist(TVSeriesTable tvSeries);
  Future<TVSeriesTable?> getTvSeriesById(int id);
  Future<List<TVSeriesTable>> getWatchlistTvSeries();
}

class TVSeriesLocalDataSourceImpl implements TVSeriesLocalDataSource {
  final DatabaseHelper databaseHelper;

  TVSeriesLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> insertTvSeriesWatchlist(TVSeriesTable tvSeries) async {
    try {
      await databaseHelper.insertWatchlistTv(tvSeries);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeTvSeriesWatchlist(TVSeriesTable tvSeries) async {
    try {
      await databaseHelper.removeWatchlistTv(tvSeries);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<TVSeriesTable?> getTvSeriesById(int id) async {
    final result = await databaseHelper.getTvById(id);
    if (result != null) {
      return TVSeriesTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<TVSeriesTable>> getWatchlistTvSeries() async {
    final result = await databaseHelper.getWatchlistTv();
    return result.map((data) => TVSeriesTable.fromMap(data)).toList();
  }
}
