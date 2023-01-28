// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TokenApiModel _$TokenApiModelFromJson(Map<String, dynamic> json) =>
    TokenApiModel(
      json['access_token'] as String,
      json['refresh_token'] as String,
      json['expires_at'] as int,
    );

Map<String, dynamic> _$TokenApiModelToJson(TokenApiModel instance) =>
    <String, dynamic>{
      'access_token': instance.accessToken,
      'refresh_token': instance.refreshToken,
      'expires_at': instance.expiresAt,
    };
