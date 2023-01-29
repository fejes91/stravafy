import 'dart:async';
import 'package:injectable/injectable.dart';
import 'package:latlong2/latlong.dart';
import 'package:stravafy/core/model/view_model.dart';
import 'package:stravafy/domain/action/activity_action.dart';
import 'package:stravafy/domain/model/activity.dart';
import 'package:stravafy/domain/store/activity_store.dart';

@injectable
class MapScreenVM extends ViewModel {
  @factoryMethod
  MapScreenVM(this._activityStore, this._activityAction) {
    _activityAction.refreshActivities();
  }

  final ActivityStore _activityStore;
  final ActivityAction _activityAction;

  Stream<List<Activity>> get activities =>
      _activityStore.getActivities().asBroadcastStream();

  Stream<List<List<LatLng>>> get polylinePoints => activities.map(
        (activities) {
          return activities
              .map(
                (activity) => activity.polylinePoints,
              )
              .toList();
        },
      ).asBroadcastStream();
}
