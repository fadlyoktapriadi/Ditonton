import 'package:bloc/bloc.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/domain/usecase/get_watchlist_tv_series.dart';
import 'package:equatable/equatable.dart';

part 'watchlist_tv_series_event.dart';

part 'watchlist_tv_series_state.dart';

class WatchlistTVSeriesBloc
    extends Bloc<WatchlistTVSeriesEvent, WatchlistTVSeriesState> {
  final GetWatchlistTvSeries _topRatedTVSeries;

  WatchlistTVSeriesBloc(this._topRatedTVSeries)
    : super(WatchlistTVSeriesEmpty()) {
    on<WatchlistTVSeriesEvent>((event, emit) async {
      emit(WatchlistTVSeriesLoading());
      final result = await _topRatedTVSeries.execute();
      result.fold(
        (failure) {
          emit(WatchlistTVSeriesError(failure.message));
        },
        (data) {
          emit(WatchlistTVSeriesHasData(data));
        },
      );
    });
  }
}
