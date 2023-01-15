import 'package:stravafy/domain/model/activity.dart';

abstract class ActivityStore {
  Stream<List<Activity>> getActivities();
}
