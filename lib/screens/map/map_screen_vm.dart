import 'dart:async';

import 'package:google_polyline_algorithm/google_polyline_algorithm.dart';
import 'package:injectable/injectable.dart';
import 'package:latlong2/latlong.dart';
import 'package:stravafy/core/model/view_model.dart';
import 'package:stravafy/domain/action/activity_action.dart';
import 'package:stravafy/domain/store/activity_store.dart';

@injectable
class MapScreenVM extends ViewModel {
  @factoryMethod
  MapScreenVM(this._activityStore, this._activityAction) {
    _activityAction.refreshActivities();
  }

  final ActivityStore _activityStore;
  final ActivityAction _activityAction;

  Stream<List<List<LatLng>>> get polylines =>
      _activityStore.getActivities().map(
        (activities) {
          return activities.map(
            (activity) {
              return _getPolylinePoints(activity.polyline);
            },
          ).toList();
        },
      ).asBroadcastStream();

  List<LatLng> _getPolylinePoints(String polylineString) =>
      decodePolyline(polylineString)
          .map(
            (coordinatePair) => LatLng(
              coordinatePair[0].toDouble(),
              coordinatePair[1].toDouble(),
            ),
          )
          .toList();
}
