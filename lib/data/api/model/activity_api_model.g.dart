// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActivityApiModel _$ActivityApiModelFromJson(Map<String, dynamic> json) =>
    ActivityApiModel(
      json['id'] as int,
      json['name'] as String,
      MapApiModel.fromJson(json['map'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ActivityApiModelToJson(ActivityApiModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'map': instance.map.toJson(),
    };
