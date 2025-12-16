import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/bloc/tv_series/watchlist/watchlist_tv_series_bloc.dart';
import 'package:ditonton/presentation/widgets/tv_series_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class WatchlistTVSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-tv-series';

  @override
  _WatchlistTVSeriesPageState createState() => _WatchlistTVSeriesPageState();
}

class _WatchlistTVSeriesPageState extends State<WatchlistTVSeriesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        context.read<WatchlistTVSeriesBloc>().add(FetchWatchlistTVSeriesEvent()));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    context.read<WatchlistTVSeriesBloc>().add(FetchWatchlistTVSeriesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<WatchlistTVSeriesBloc, WatchlistTVSeriesState>(
          builder: (context, state) {
            if (state is WatchlistTVSeriesLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is WatchlistTVSeriesHasData) {
              final result = state.result;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvSeries = result[index];
                  return TvSeriesCard(tvSeries );
                },
                itemCount: result.length,
              );
            } else if (state is WatchlistTVSeriesError) {
              return Center(child: Text(state.message));
            } else {
              return Text('Failed');
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
