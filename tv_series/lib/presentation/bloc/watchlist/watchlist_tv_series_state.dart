part of 'watchlist_tv_series_bloc.dart';

abstract class WatchlistTVSeriesState extends Equatable {
  const WatchlistTVSeriesState();

  @override
  List<Object> get props => [];
}

class WatchlistTVSeriesEmpty extends WatchlistTVSeriesState {}

class WatchlistTVSeriesLoading extends WatchlistTVSeriesState {}

class WatchlistTVSeriesError extends WatchlistTVSeriesState {
  final String message;

  WatchlistTVSeriesError(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistTVSeriesHasData extends WatchlistTVSeriesState {
  final List<TVSeries> result;

  WatchlistTVSeriesHasData(this.result);

  @override
  List<Object> get props => [result];
}