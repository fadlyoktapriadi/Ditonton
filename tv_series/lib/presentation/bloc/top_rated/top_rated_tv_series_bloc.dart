import 'package:bloc/bloc.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/domain/usecase/get_top_rated_tv_series.dart';
import 'package:equatable/equatable.dart';

part 'top_rated_tv_series_event.dart';
part 'top_rated_tv_series_state.dart';

class TopRatedTVSeriesBloc
    extends Bloc<TopRatedTVSeriesEvent, TopRatedTVSeriesState> {
  final GetTopRatedTvSeries _topRatedTVSeries;

  TopRatedTVSeriesBloc(this._topRatedTVSeries) : super(TopRatedTVSeriesEmpty()) {
    on<TopRatedTVSeriesEvent>((event, emit) async {
      emit(TopRatedTVSeriesLoading());
      final result = await _topRatedTVSeries.execute();
      result.fold(
            (failure) {
          emit(TopRatedTVSeriesError(failure.message));
        },
            (data) {
          emit(TopRatedTVSeriesHasData(data));
        },
      );
    });
  }
}
