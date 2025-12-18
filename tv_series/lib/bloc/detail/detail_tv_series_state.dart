part of 'detail_tv_series_bloc.dart';

class TVSeriesDetailState extends Equatable {
  final RequestState tvSeriesState;
  final TvSeriesDetail? tvSeries;
  final RequestState recommendationState;
  final List<TVSeries> tvSeriesRecommendations;
  final String message;
  final bool isAddedToWatchlist;
  final String watchlistMessage;

  const TVSeriesDetailState({
    this.tvSeriesState = RequestState.Empty,
    this.tvSeries,
    this.recommendationState = RequestState.Empty,
    this.tvSeriesRecommendations = const [],
    this.message = '',
    this.isAddedToWatchlist = false,
    this.watchlistMessage = '',
  });

  TVSeriesDetailState copyWith({
    RequestState? tvSeriesState,
    TvSeriesDetail? tvSeries,
    RequestState? recommendationState,
    List<TVSeries>? tvSeriesRecommendations,
    String? message,
    bool? isAddedToWatchlist,
    String? watchlistMessage,
  }) {
    return TVSeriesDetailState(
      tvSeriesState: tvSeriesState ?? this.tvSeriesState,
      tvSeries: tvSeries ?? this.tvSeries,
      recommendationState: recommendationState ?? this.recommendationState,
      tvSeriesRecommendations: tvSeriesRecommendations ?? this.tvSeriesRecommendations,
      message: message ?? this.message,
      isAddedToWatchlist: isAddedToWatchlist ?? this.isAddedToWatchlist,
      watchlistMessage: watchlistMessage ?? this.watchlistMessage,
    );
  }

  @override
  List<Object?> get props => [
    tvSeriesState,
    tvSeries,
    recommendationState,
    tvSeriesRecommendations,
    message,
    isAddedToWatchlist,
    watchlistMessage,
  ];
}