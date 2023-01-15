import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:stravafy/data/api/model/activity_api_model.dart';

part 'strava_client.g.dart';

@RestApi()
abstract class StravaClient {
  factory StravaClient(Dio dio, {String baseUrl}) = _StravaClient;

  @GET("/athlete/activities")
  Future<List<ActivityApiModel>> refreshActivities();
}
