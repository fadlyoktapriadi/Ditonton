import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_now_playing_tv_series.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'now_playing_tv_series_event.dart';

part 'now_playing_tv_series_state.dart';

class NowPlayingTVSeriesBloc
    extends Bloc<NowPlayingTVSeriesEvent, NowPlayingTVSeriesState> {
  final GetNowPlayingTvSeries _nowPlayingTvSeries;

  NowPlayingTVSeriesBloc(this._nowPlayingTvSeries)
    : super(NowPlayingTVSeriesEmpty()) {
    on<NowPlayingTVSeriesEvent>((event, emit) async {
      emit(NowPlayingTVSeriesLoading());
      final result = await _nowPlayingTvSeries.execute();
      result.fold(
        (failure) {
          emit(NowPlayingTVSeriesError(failure.message));
        },
        (data) {
          emit(NowPlayingTVSeriesHasData(data));
        },
      );
    });
  }
}
