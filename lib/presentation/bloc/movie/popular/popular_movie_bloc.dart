import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'popular_movie_event.dart';
part 'popular_movie_state.dart';

class PopularMovieBloc
    extends Bloc<PopularMovieEvent, PopularMovieState> {
  final GetPopularMovies _popularMovies;

  PopularMovieBloc(this._popularMovies) : super(PopularMovieEmpty()) {
    on<PopularMovieEvent>((event, emit) async {
      emit(PopularMovieLoading());
      final result = await _popularMovies.execute();

      result.fold(
            (failure) {
          emit(PopularMovieError(failure.message));
        },
            (data) {
          emit(PopularMovieHasData(data));
        },
      );
    });
  }
}