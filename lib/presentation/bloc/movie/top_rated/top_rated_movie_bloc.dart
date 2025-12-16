import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:equatable/equatable.dart';

part 'top_rated_movie_event.dart';
part 'top_rated_movie_state.dart';

class TopRatedMovieBloc
    extends Bloc<TopRatedMovieEvent, TopRatedMovieState> {
  final GetTopRatedMovies _topRatedMovies;

  TopRatedMovieBloc(this._topRatedMovies) : super(TopRatedMovieEmpty()) {
    on<TopRatedMovieEvent>((event, emit) async {
      emit(TopRatedMovieLoading());
      final result = await _topRatedMovies.execute();

      result.fold(
            (failure) {
          emit(TopRatedMovieError(failure.message));
        },
            (data) {
          emit(TopRatedMovieHasData(data));
        },
      );
    });
  }
}