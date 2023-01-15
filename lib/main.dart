import 'package:flutter/material.dart';
import 'package:stravafy/di/injectable.dart';
import 'package:stravafy/screens/map/map_screen.dart';

void main() {
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stravafy',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const MapScreen(),
    );
  }
}
