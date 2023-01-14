import 'package:flutter/material.dart';
import 'package:stravafy/screens/main/map_screen.dart';

void main() {
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
