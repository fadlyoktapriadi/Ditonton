import 'package:core/common/constants.dart';
import 'package:core/common/utils.dart';
import 'package:core/common/http_ssl_pinning.dart';
import 'package:ditonton/injection.dart' as di;
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:tv_series/bloc/detail/detail_tv_series_bloc.dart';
import 'package:tv_series/bloc/now_playing/now_playing_tv_series_bloc.dart';
import 'package:tv_series/bloc/popular/popular_tv_series_bloc.dart';
import 'package:tv_series/bloc/search/search_tv_series_bloc.dart';
import 'package:tv_series/bloc/top_rated/top_rated_tv_series_bloc.dart';
import 'package:tv_series/bloc/watchlist/watchlist_tv_series_bloc.dart';
import 'package:core/pages/about_page.dart';
import 'package:movie/presentation/home_movie_page.dart';
import 'package:movie/presentation/popular_movies_page.dart';
import 'package:movie/presentation/search_page.dart';
import 'package:movie/presentation/top_rated_movies_page.dart';
import 'package:movie/presentation/movie_detail_page.dart';
import 'package:movie/bloc/detail/detail_movie_bloc.dart';
import 'package:movie/bloc/now_playing/now_playing_movie_bloc.dart';
import 'package:movie/bloc/popular/popular_movie_bloc.dart';
import 'package:movie/bloc/search/search_movie_bloc.dart';
import 'package:movie/bloc/top_rated/top_rated_movie_bloc.dart';
import 'package:movie/presentation/watchlist_movies_page.dart';
import 'package:tv_series/presentation/now_playing_tv_series_page.dart';
import 'package:tv_series/presentation/popular_tv_series_page.dart';
import 'package:tv_series/presentation/search_tv_series_page.dart';
import 'package:tv_series/presentation/top_rated_tv_series_page.dart';
import 'package:tv_series/presentation/tv_series_detail_page.dart';
import 'package:tv_series/presentation/tv_series_page.dart';
import 'package:tv_series/presentation/watchlist_tv_series_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/bloc/watchlist/watchlist_movie_bloc.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HttpSSLPinning.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
  FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(
          create: (_) => di.locator<NowPlayingMovieBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularMovieBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedMovieBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SearchBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistMovieBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<NowPlayingTVSeriesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularTVSeriesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedTVSeriesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SearchTVSeriesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TVSeriesDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistTVSeriesBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
          drawerTheme: kDrawerTheme,
        ),
        home: HomeMoviePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(builder: (_) => HomeMoviePage());
            case PopularMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case TopRatedMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case MovieDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case SearchPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchPage());
            case WatchlistMoviesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());
            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => AboutPage());
            case TVSeriesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => TVSeriesPage());
            case NowPlayingTVSeriesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => NowPlayingTVSeriesPage());
            case PopularTVSeriesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => PopularTVSeriesPage());
            case TopRatedTvSeriesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => TopRatedTvSeriesPage());
            case TVSeriesDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TVSeriesDetailPage(id: id),
                settings: settings,
              );
            case SearchTVSeriesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchTVSeriesPage());
            case WatchlistTVSeriesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistTVSeriesPage());
            default:
              return MaterialPageRoute(
                builder: (_) {
                  return Scaffold(
                    body: Center(child: Text('Page not found :(')),
                  );
                },
              );
          }
        },
      ),
    );
  }
}
