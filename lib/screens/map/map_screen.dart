import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get_it/get_it.dart';
import 'package:latlong2/latlong.dart';
import 'package:stravafy/domain/model/activity.dart';
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

  int _selectedActivityIndex = 0;
  late double _panelHeight;

  @override
  void initState() {
    super.initState();

    _viewModel = GetIt.I<MapScreenVM>();
  }

  void onMapReady() {
    // TODO duplicated subscription
    _polylineSubscription = _viewModel.polylinePoints.listen((polylinePoints) {
      final mergedPolylines =
          polylinePoints.expand((element) => element).toList();

      _adjustMap(mergedPolylines);
    });
  }

  @override
  void dispose() {
    _polylineSubscription?.cancel();
    _viewModel.dispose();
    super.dispose();
  }

  PolylineLayer _getPolylineLayer(List<List<LatLng>>? polylines) {
    final polylineLayers = polylines
            ?.asMap()
            .entries
            .map(
              (entry) => Polyline(
                points: entry.value,
                color: entry.key == _selectedActivityIndex
                    ? colors[entry.key % colors.length]
                    : Colors.grey,
                strokeWidth: 2.5,
                borderStrokeWidth: 2.0,
                borderColor: Colors.white,
              ),
            )
            .toList() ??
        [];

    polylineLayers.add(polylineLayers[_selectedActivityIndex]);
    polylineLayers.removeAt(_selectedActivityIndex);

    return PolylineLayer(polylineCulling: true, polylines: polylineLayers);
  }

  void _adjustMap(List<LatLng> points) {
    const double mapMargin = 32;

    _mapController.fitBounds(
      LatLngBounds.fromPoints(points),
      options: FitBoundsOptions(
        padding: //EdgeInsets.all(mapMargin)
            EdgeInsets.only(
          top: mapMargin,
          left: mapMargin,
          bottom: _panelHeight + mapMargin,
          right: mapMargin,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _panelHeight = MediaQuery.of(context).size.height * 0.2;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Stravafy'),
      ),
      body: Stack(
        children: [
          _map(),
          Align(alignment: Alignment.bottomCenter, child: _panelContent())
        ],
      ),
    );
  }

  Widget _panelContent() {
    return StreamBuilder<List<Activity>>(
      initialData: const [],
      stream: _viewModel.activities,
      builder: (context, activities) => Container(
        height: _panelHeight,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
        ),
        child: CupertinoPicker(
            itemExtent: 30,
            onSelectedItemChanged: (selectedIndex) {
              setState(() {
                _selectedActivityIndex = selectedIndex;
                final selectedActivity = activities.data?[selectedIndex];

                if (selectedActivity != null) {
                  _adjustMap(selectedActivity.polylinePoints);
                }
              });
            },
            children: _getPickerItems(activities.data ?? [])),
      ),
    );
  }

  Widget _map() {
    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(
        onMapReady: onMapReady,
        center: LatLng(47.509364, 19.128928),
        zoom: 9,
      ),
      nonRotatedChildren: const [],
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'hu.adamfejes.stravafy',
        ),
        StreamBuilder<List<List<LatLng>>>(
          initialData: null,
          stream: _viewModel.polylinePoints,
          builder: (context, polylines) {
            return _getPolylineLayer(polylines.data);
          },
        )
      ],
    );
  }

  List<Widget> _getPickerItems(List<Activity> activities) {
    return activities.map((activity) => Text(activity.name)).toList();
  }
}
