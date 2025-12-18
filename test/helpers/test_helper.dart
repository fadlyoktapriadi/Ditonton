import 'package:core/data/datasources/local/db/database_helper.dart';
import 'package:core/data/datasources/local/movie_local_data_source.dart';
import 'package:core/data/datasources/remote/movie_remote_data_source.dart';
import 'package:core/data/datasources/local/tv_series_local_data_source.dart';
import 'package:core/data/datasources/remote/tv_series_remote_data_source.dart';
import 'package:movie/domain/repository/movie_repository.dart';
import 'package:tv_series/domain/repository/tv_series_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([
  MovieRepository,
  MovieRemoteDataSource,
  MovieLocalDataSource,
  TVSeriesRepository,
  TVSeriesLocalDataSource,
  TVSeriesRemoteDataSource,
  DatabaseHelper,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
