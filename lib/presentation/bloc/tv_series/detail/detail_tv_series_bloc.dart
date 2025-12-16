import 'package:bloc/bloc.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_series_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_series_recommendations.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv_series.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv_series_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_tv_series.dart';
import 'package:ditonton/domain/usecases/save_watchlist_tv_series.dart';
import 'package:equatable/equatable.dart';

part 'detail_tv_series_event.dart';

part 'detail_tv_series_state.dart';

class TVSeriesDetailBloc
    extends Bloc<TVSeriesDetailEvent, TVSeriesDetailState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetTvSeriesDetail getTVSeriesDetail;
  final GetTvSeriesRecommendations getTVSeriesRecommendations;
  final GetWatchListTvSeriesStatus getWatchListStatus;
  final SaveTvSeriesWatchlist saveWatchlist;
  final RemoveTvSeriesWatchlist removeWatchlist;

  TVSeriesDetailBloc(
    this.getTVSeriesDetail,
    this.getTVSeriesRecommendations,
    this.getWatchListStatus,
    this.saveWatchlist,
    this.removeWatchlist,
  ) : super(const TVSeriesDetailState()) {
    on<FetchTVSeriesDetail>(_onFetchTVSeriesDetail);
    on<AddToWatchlist>(_onAddToWatchlist);
    on<RemoveFromWatchlist>(_onRemoveFromWatchlist);
    on<LoadWatchlistStatus>(_onLoadWatchlistStatus);
  }

  Future<void> _onFetchTVSeriesDetail(
    FetchTVSeriesDetail event,
    Emitter<TVSeriesDetailState> emit,
  ) async {
    emit(state.copyWith(tvSeriesState: RequestState.Loading));

    final detailResult = await getTVSeriesDetail.execute(event.id);
    final recommendationResult = await getTVSeriesRecommendations.execute(
      event.id,
    );

    detailResult.fold(
      (failure) {
        emit(
          state.copyWith(
            tvSeriesState: RequestState.Error,
            message: failure.message,
          ),
        );
      },
      (movie) {
        emit(
          state.copyWith(
            tvSeries: movie,
            tvSeriesState: RequestState.Loaded,
            recommendationState: RequestState.Loading,
          ),
        );

        recommendationResult.fold(
          (failure) {
            emit(
              state.copyWith(
                recommendationState: RequestState.Error,
                message: failure.message,
              ),
            );
          },
          (movies) {
            emit(
              state.copyWith(
                recommendationState: RequestState.Loaded,
                tvSeriesRecommendations: movies,
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _onAddToWatchlist(
    AddToWatchlist event,
    Emitter<TVSeriesDetailState> emit,
  ) async {
    final result = await saveWatchlist.execute(event.tvSeries);

    await result.fold(
      (failure) async {
        emit(state.copyWith(watchlistMessage: failure.message));
      },
      (successMessage) async {
        emit(state.copyWith(watchlistMessage: successMessage));
      },
    );

    add(LoadWatchlistStatus(event.tvSeries.id));
  }

  Future<void> _onRemoveFromWatchlist(
    RemoveFromWatchlist event,
    Emitter<TVSeriesDetailState> emit,
  ) async {
    final result = await removeWatchlist.execute(event.tvSeries);

    await result.fold(
      (failure) async {
        emit(state.copyWith(watchlistMessage: failure.message));
      },
      (successMessage) async {
        emit(state.copyWith(watchlistMessage: successMessage));
      },
    );

    add(LoadWatchlistStatus(event.tvSeries.id));
  }

  Future<void> _onLoadWatchlistStatus(
    LoadWatchlistStatus event,
    Emitter<TVSeriesDetailState> emit,
  ) async {
    final result = await getWatchListStatus.execute(event.id);
    emit(state.copyWith(isAddedToWatchlist: result));
  }
}
