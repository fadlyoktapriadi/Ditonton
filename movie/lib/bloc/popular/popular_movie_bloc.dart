import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecase/get_popular_movies.dart';

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