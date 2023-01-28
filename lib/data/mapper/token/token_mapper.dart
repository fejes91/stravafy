import 'package:stravafy/data/api/model/token_api_model.dart';
import 'package:stravafy/data/database/model/token_data_model.dart';

extension TokenMapper on TokenApiModel {
  TokenDataModel toDataModel() => TokenDataModel(
        accessToken: accessToken,
        refreshToken: refreshToken,
        expiresAt: expiresAt,
      );
}
