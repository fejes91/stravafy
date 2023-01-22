import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:stravafy/data/api/strava_client.dart';
import 'package:stravafy/domain/store/token_store.dart';

@module
abstract class NetworkModule {
  final authEndpoint = '/oauth/token';

  @singleton
  Dio provideDio(TokenStore tokenStore) {
    final dio = Dio();

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest:
            (RequestOptions options, RequestInterceptorHandler handler) async {
          if (needAuthHeader(options.uri)) {
            options.headers['Authorization'] =
                'Bearer ${await tokenStore.getAccessToken()}';
          }
          handler.next(options);
        },
      ),
    );

    return dio;
  }

  bool needAuthHeader(Uri uri) => !uri.toString().contains(authEndpoint);

  @singleton
  StravaClient providStravaClient(Dio dio) =>
      StravaClient(dio, baseUrl: 'https://www.strava.com/api/v3/');
}
