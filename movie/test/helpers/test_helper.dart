import 'package:core/helper/database_helper.dart';
import 'package:movie/data/datasources/local/movie_local_data_source.dart';
import 'package:movie/data/datasources/remote/movie_remote_data_source.dart';
import 'package:movie/domain/repository/movie_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([
  MovieRepository,
  MovieRemoteDataSource,
  MovieLocalDataSource,
  DatabaseHelper,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
