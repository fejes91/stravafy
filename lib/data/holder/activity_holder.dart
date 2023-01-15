import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:stravafy/domain/model/activity.dart';

@singleton
class ActivityHolder {
  final StreamController<List<Activity>> _activitiesController =
      StreamController<List<Activity>>.broadcast();

  Stream<List<Activity>> get activities => _activitiesController.stream;

  void setActivities(List<Activity> activities) {
    _activitiesController.add(activities);
  }
}
