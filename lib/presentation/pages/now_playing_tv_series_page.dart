import 'package:ditonton/presentation/bloc/tv_series/now_playing/now_playing_tv_series_bloc.dart';
import 'package:ditonton/presentation/widgets/tv_series_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class NowPlayingTVSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/now-playing-tv-series';

  @override
  _NowPlayingTVSeriesPageState createState() => _NowPlayingTVSeriesPageState();
}

class _NowPlayingTVSeriesPageState extends State<NowPlayingTVSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
          () => context.read<NowPlayingTVSeriesBloc>().add(FetchNowPlayingTVSeriesEvent()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Now Playing TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<NowPlayingTVSeriesBloc, NowPlayingTVSeriesState>(
          builder: (context, state) {
            if (state is NowPlayingTVSeriesLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is NowPlayingTVSeriesHasData) {
              final result = state.result;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = result[index];
                  return TvSeriesCard(movie);
                },
                itemCount: result.length,
              );
            } else if (state is NowPlayingTVSeriesError) {
              return Center(child: Text(state.message));
            } else {
              return Text('Failed');
            }
          },
        ),
      ),
    );
  }
}
