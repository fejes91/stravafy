import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get_it/get_it.dart';
import 'package:google_polyline_algorithm/google_polyline_algorithm.dart';
import 'package:latlong2/latlong.dart';
import 'package:stravafy/screens/map/map_screen_vm.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  StreamSubscription? _polylineSubscription;
  final MapController _mapController = MapController();
  late MapScreenVM _viewModel;

  @override
  void initState() {
    super.initState();

    _viewModel = GetIt.I<MapScreenVM>();
  }

  void onMapReady() {
    _polylineSubscription = _viewModel.polylines.listen((polylinePoints) {
      _adjustMap(polylinePoints);
    });
  }

  @override
  void dispose() {
    _polylineSubscription?.cancel();
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stravafy'),
      ),
      body: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          onMapReady: onMapReady,
          center: LatLng(47.509364, 19.128928),
          zoom: 9,
        ),
        nonRotatedChildren: [],
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'hu.adamfejes.stravafy',
          ),
          StreamBuilder<List<LatLng>>(
            initialData: const <LatLng>[],
            stream: _viewModel.polylines,
            builder: (context, polyline) {
              return _getPolylineLayer(polyline.data!);
            },
          )
        ],
      ),
    );
  }

  PolylineLayer _getPolylineLayer(List<LatLng> polyline) {
    return PolylineLayer(
      polylineCulling: true,
      polylines: [
        Polyline(
          points: polyline,
          color: Colors.red,
          strokeWidth: 2.5,
          borderStrokeWidth: 2.0,
          borderColor: Colors.white,
        ),
      ],
    );
  }

  void _adjustMap(List<LatLng> points) {
    _mapController.fitBounds(LatLngBounds.fromPoints(points),
        options: const FitBoundsOptions(padding: EdgeInsets.all(32)));
  }
}
