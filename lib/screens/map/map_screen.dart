import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get_it/get_it.dart';
import 'package:latlong2/latlong.dart';
import 'package:stravafy/screens/map/map_screen_vm.dart';

const colors = [
  Colors.red,
  Colors.green,
  Colors.blue,
  Colors.yellow,
  Colors.amber,
];

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
          StreamBuilder<List<List<LatLng>>>(
            initialData: null,
            stream: _viewModel.polylines,
            builder: (context, polylines) {
              return _getPolylineLayer(polylines.data);
            },
          )
        ],
      ),
    );
  }

  PolylineLayer _getPolylineLayer(List<List<LatLng>>? polylines) {
    return PolylineLayer(
        polylineCulling: true,
        polylines: polylines
                ?.asMap()
                .entries
                .map(
                  (entry) => Polyline(
                    points: entry.value,
                    color: colors[entry.key % colors.length],
                    strokeWidth: 2.5,
                    borderStrokeWidth: 2.0,
                    borderColor: Colors.white,
                  ),
                )
                .toList() ??
            []);
  }

  void _adjustMap(List<List<LatLng>>? points) {
    final mergedPolylines =
        points?.reduce((value, element) => value..addAll(element)) ?? [];

    _mapController.fitBounds(LatLngBounds.fromPoints(mergedPolylines),
        options: const FitBoundsOptions(padding: EdgeInsets.all(32)));
  }
}
