import 'package:json_annotation/json_annotation.dart';

part 'map.g.dart';

@JsonSerializable(explicitToJson: true)
class MapApiModel {
  @JsonKey(name: 'summary_polyline')
  String polyline;

  MapApiModel(this.polyline);

  factory MapApiModel.fromJson(Map<String, dynamic> json) =>
      _$MapApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$MapApiModelToJson(this);
}
