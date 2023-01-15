import 'package:json_annotation/json_annotation.dart';
import 'package:stravafy/data/api/model/map.dart';

part 'activity_api_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ActivityApiModel {
  int id;
  String name;
  MapApiModel map;

  ActivityApiModel(this.id, this.name, this.map);

  factory ActivityApiModel.fromJson(Map<String, dynamic> json) =>
      _$ActivityApiModelFromJson(json);

  @override
  String toString() {
    return 'ActivityApiModel{id: $id, name: $name, map: $map}';
  }
}
