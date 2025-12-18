import 'package:core/helper/database_helper.dart';
import 'package:tv_series/data/datasources/local/tv_series_local_data_source.dart';
import 'package:tv_series/data/datasources/remote/tv_series_remote_data_source.dart';
import 'package:tv_series/domain/repository/tv_series_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([
  TVSeriesRepository,
  TVSeriesLocalDataSource,
  TVSeriesRemoteDataSource,
  DatabaseHelper,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
