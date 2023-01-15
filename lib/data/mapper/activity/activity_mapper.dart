import 'package:stravafy/data/api/model/activity_api_model.dart';
import 'package:stravafy/domain/model/activity.dart';

extension ActivityMapper on ActivityApiModel {
  Activity toDomainModel() => Activity(
        id: id.toString(),
        name: name,
        polyline: map.polyline,
      );
}
