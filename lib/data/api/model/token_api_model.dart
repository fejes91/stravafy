import 'package:json_annotation/json_annotation.dart';

part 'token_api_model.g.dart';

@JsonSerializable(explicitToJson: true)
class TokenApiModel {
  @JsonKey(name: 'access_token')
  String accessToken;
  @JsonKey(name: 'refresh_token')
  String refreshToken;
  @JsonKey(name: 'expires_at')
  int expiresAt;

  TokenApiModel(this.accessToken, this.refreshToken, this.expiresAt);

  factory TokenApiModel.fromJson(Map<String, dynamic> json) =>
      _$TokenApiModelFromJson(json);

  @override
  String toString() {
    return 'TokenApiModel{accessToken: $accessToken}';
  }
}
