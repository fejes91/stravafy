import 'package:floor/floor.dart';

@entity
class TokenDataModel {
  @primaryKey
  final int id = 1;
  final String accessToken;
  final String refreshToken;
  final int expiresAt;

  TokenDataModel({
    required this.accessToken,
    required this.refreshToken,
    required this.expiresAt,
  });
}
