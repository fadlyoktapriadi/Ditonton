import 'package:core/common/http_ssl_pinning.dart';
import 'package:core/data/datasources/local/db/database_helper.dart';
import 'package:core/data/datasources/local/movie_local_data_source.dart';
import 'package:core/data/datasources/remote/movie_remote_data_source.dart';
import 'package:core/data/datasources/local/tv_series_local_data_source.dart';
import 'package:core/data/datasources/remote/tv_series_remote_data_source.dart';
import 'package:core/data/repositories/movie_repository_impl.dart';
import 'package:core/data/repositories/tv_series_repository_impl.dart';
import 'package:movie/bloc/now_playing/now_playing_movie_bloc.dart';
import 'package:movie/bloc/popular/popular_movie_bloc.dart';
import 'package:movie/bloc/top_rated/top_rated_movie_bloc.dart';
import 'package:movie/bloc/search/search_movie_bloc.dart';
import 'package:movie/bloc/detail/detail_movie_bloc.dart';
import 'package:movie/bloc/watchlist/watchlist_movie_bloc.dart';
import 'package:movie/domain/repository/movie_repository.dart';
import 'package:movie/domain/usecase/get_movie_detail.dart';
import 'package:movie/domain/usecase/get_movie_recommendations.dart';
import 'package:movie/domain/usecase/get_now_playing_movies.dart';
import 'package:movie/domain/usecase/get_popular_movies.dart';
import 'package:movie/domain/usecase/get_top_rated_movies.dart';
import 'package:movie/domain/usecase/get_watchlist_status.dart';
import 'package:tv_series/domain/usecase/get_watchlist_tv_series.dart';
import 'package:tv_series/domain/repository/tv_series_repository.dart';
import 'package:tv_series/domain/usecase/get_now_playing_tv_series.dart';
import 'package:tv_series/domain/usecase/get_popular_tv_series.dart';
import 'package:tv_series/domain/usecase/get_top_rated_tv_series.dart';
import 'package:tv_series/domain/usecase/get_tv_series_detail.dart';
import 'package:tv_series/domain/usecase/get_tv_series_recommendations.dart';
import 'package:tv_series/domain/usecase/get_watchlist_tv_series_status.dart';
import 'package:tv_series/domain/usecase/remove_watchlist_tv_series.dart';
import 'package:tv_series/domain/usecase/save_watchlist_tv_series.dart';
import 'package:tv_series/bloc/detail/detail_tv_series_bloc.dart';
import 'package:tv_series/bloc/now_playing/now_playing_tv_series_bloc.dart';
import 'package:tv_series/bloc/popular/popular_tv_series_bloc.dart';
import 'package:tv_series/bloc/search/search_tv_series_bloc.dart';
import 'package:tv_series/bloc/top_rated/top_rated_tv_series_bloc.dart';
import 'package:tv_series/bloc/watchlist/watchlist_tv_series_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:movie/domain/usecase/get_watchlist_movies.dart';
import 'package:movie/domain/usecase/remove_watchlist.dart';
import 'package:movie/domain/usecase/save_watchlist.dart';
import 'package:movie/domain/usecase/search_movies.dart';
import 'package:tv_series/domain/usecase/search_tv_series.dart';


final locator = GetIt.instance;

void init() {
  locator.registerFactory(() => NowPlayingMovieBloc(locator()));
  locator.registerFactory(() => PopularMovieBloc(locator()));
  locator.registerFactory(() => TopRatedMovieBloc(locator()));
  locator.registerFactory(() => SearchBloc(locator()));
  locator.registerFactory(() => MovieDetailBloc(locator(), locator(), locator(), locator(), locator()));
  locator.registerFactory(() => WatchlistMovieBloc(locator()));
  locator.registerFactory(() => NowPlayingTVSeriesBloc(locator()));
  locator.registerFactory(() => PopularTVSeriesBloc(locator()));
  locator.registerFactory(() => TopRatedTVSeriesBloc(locator()));
  locator.registerFactory(() => SearchTVSeriesBloc(locator()));
  locator.registerFactory(() => TVSeriesDetailBloc(locator(), locator(), locator(), locator(), locator()));
  locator.registerFactory(() => WatchlistTVSeriesBloc(locator()));

  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchlistStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));
  locator.registerLazySingleton(() => GetNowPlayingTvSeries(locator()));
  locator.registerLazySingleton(() => GetPopularTvSeries(locator()));
  locator.registerLazySingleton(() => GetTopRatedTvSeries(locator()));
  locator.registerLazySingleton(() => GetTvSeriesDetail(locator()));
  locator.registerLazySingleton(() => GetTvSeriesRecommendations(locator()));
  locator.registerLazySingleton(() => SearchTvSeries(locator()));
  locator.registerLazySingleton(() => SaveTvSeriesWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveTvSeriesWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchListTvSeriesStatus(locator()));
  locator.registerLazySingleton(() => GetWatchlistTvSeries(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  locator.registerLazySingleton<TVSeriesRepository>(
    () => TvSeriesRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
    () => MovieRemoteDataSourceImpl(client: locator()),
  );

  locator.registerLazySingleton<TVSeriesRemoteDataSource>(
    () => TVSeriesRemoteDataSourceImpl(client: locator()),
  );

  locator.registerLazySingleton<MovieLocalDataSource>(
    () => MovieLocalDataSourceImpl(databaseHelper: locator()),
  );

  locator.registerLazySingleton<TVSeriesLocalDataSource>(
    () => TVSeriesLocalDataSourceImpl(databaseHelper: locator()),
  );

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // External
  locator.registerLazySingleton(() => HttpSSLPinning.client);

}
