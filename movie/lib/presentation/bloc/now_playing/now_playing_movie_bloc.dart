import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecase/get_now_playing_movies.dart';

part 'now_playing_movie_event.dart';

part 'now_playing_movie_state.dart';

class NowPlayingMovieBloc
    extends Bloc<NowPlayingMovieEvent, NowPlayingMovieState> {
  final GetNowPlayingMovies _nowPlayingMovies;

  NowPlayingMovieBloc(this._nowPlayingMovies) : super(NowPlayingMovieEmpty()) {
    on<NowPlayingMovieEvent>((event, emit) async {
      emit(NowPlayingMovieLoading());
      final result = await _nowPlayingMovies.execute();

      result.fold(
        (failure) {
          emit(NowPlayingMovieError(failure.message));
        },
        (data) {
          emit(NowPlayingMovieHasData(data));
        },
      );
    });
  }
}