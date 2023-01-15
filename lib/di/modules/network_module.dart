import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:stravafy/data/api/strava_client.dart';

@module
abstract class NetworkModule {
  @singleton
  Dio provideDio() {
    final dio = Dio();

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
          options.headers.putIfAbsent('Authorization',
              () => 'Bearer 295e6c52f9c0ff306956bc9e5983d16c74878331');
          handler.next(options);
        },
      ),
    );

    return dio;
  }

  @singleton
  StravaClient providStravaClient(Dio dio) =>
      StravaClient(dio, baseUrl: 'https://www.strava.com/api/v3/');
}
