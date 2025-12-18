import 'package:bloc/bloc.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/domain/usecase/get_popular_tv_series.dart';
import 'package:equatable/equatable.dart';

part 'popular_tv_series_event.dart';

part 'popular_tv_series_state.dart';

class PopularTVSeriesBloc
    extends Bloc<PopularTVSeriesEvent, PopularTVSeriesState> {
  final GetPopularTvSeries _popularTvSeries;

  PopularTVSeriesBloc(this._popularTvSeries) : super(PopularTVSeriesEmpty()) {
    on<PopularTVSeriesEvent>((event, emit) async {
      emit(PopularTVSeriesLoading());
      final result = await _popularTvSeries.execute();
      result.fold(
        (failure) {
          emit(PopularTVSeriesError(failure.message));
        },
        (data) {
          emit(PopularTVSeriesHasData(data));
        },
      );
    });
  }
}
