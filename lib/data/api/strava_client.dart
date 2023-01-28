import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:stravafy/constants.dart';
import 'package:stravafy/data/api/model/activity_api_model.dart';
import 'package:stravafy/data/api/model/token_api_model.dart';

part 'strava_client.g.dart';

@RestApi()
abstract class StravaClient {
  factory StravaClient(Dio dio, {String baseUrl}) = _StravaClient;

  @POST("/oauth/token")
  Future<TokenApiModel> postTokenCode(
    @Query("code") String tokenCode, {
    @Query("client_id") String clientId = stravaClientId,
    @Query("client_secret") String clientSecret = stravaClientSecret,
    @Query("grant_type") String grantType = 'authorization_code',
  });

  @GET("/athlete/activities")
  Future<List<ActivityApiModel>> refreshActivities();

  @POST("/oauth/token")
  Future<TokenApiModel> refreshToken(
    @Query("refresh_token") String refreshToken, {
    @Query("client_id") String clientId = stravaClientId,
    @Query("client_secret") String clientSecret = stravaClientSecret,
    @Query("grant_type") String grantType = 'refresh_token',
  });
}
