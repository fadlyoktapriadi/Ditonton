import 'package:bloc/bloc.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/domain/usecase/search_tv_series.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

part 'search_tv_series_event.dart';
part 'search_tv_series_state.dart';

class SearchTVSeriesBloc extends Bloc<SearchTVSeriesEvent, SearchTVSeriesState> {
  final SearchTvSeries _searchTVSeries;

  SearchTVSeriesBloc(this._searchTVSeries) : super(SearchTVSeriesEmpty()) {
    on<OnQueryChanged>((event, emit) async {
      final query = event.query;

      emit(SearchTVSeriesLoading());
      final result = await _searchTVSeries.execute(query);

      result.fold(
            (failure) {
          emit(SearchTVSeriesError(failure.message));
        },
            (data) {
          emit(SearchTVSeriesHasData(data));
        },
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}