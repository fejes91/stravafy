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
  late MapScreenVM _viewModel;

  @override
  void initState() {
    super.initState();

    _viewModel = GetIt.I<MapScreenVM>();
  }

  @override
  void dispose() {
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
        options: MapOptions(
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
            builder: (context, polyline) => PolylineLayer(
              polylineCulling: true,
              polylines: [
                Polyline(
                  points: polyline.data!,
                  color: Colors.red,
                  strokeWidth: 2.5,
                  borderStrokeWidth: 2.0,
                  borderColor: Colors.white,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
