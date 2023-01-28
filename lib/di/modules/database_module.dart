import 'package:injectable/injectable.dart';
import 'package:stravafy/data/database/stravafy_database.dart';

@module
abstract class DatabaseModule {
  @singleton
  @preResolve
  Future<StravafyDatabase> provideMovieDatabase() =>
      $FloorStravafyDatabase.databaseBuilder('stravafy_database.db').build();
}
