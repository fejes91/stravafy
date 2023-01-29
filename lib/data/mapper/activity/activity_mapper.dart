import 'package:google_polyline_algorithm/google_polyline_algorithm.dart';
import 'package:latlong2/latlong.dart';
import 'package:stravafy/data/api/model/activity_api_model.dart';
import 'package:stravafy/domain/model/activity.dart';

extension ActivityMapper on ActivityApiModel {
  Activity toDomainModel() => Activity(
        id: id.toString(),
        name: name,
        polylinePoints: _getPolylinePoints(map.polyline),
      );

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
