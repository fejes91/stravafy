import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:stravafy/screens/auth/auth_screen_vm.dart';
import 'package:stravafy/screens/map/map_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  late AuthScreenVM _viewModel;
  StreamSubscription? _authSubscription;

  @override
  void initState() {
    super.initState();
    _viewModel = GetIt.I<AuthScreenVM>();

    _authSubscription = _viewModel.authenticated.listen((authenticated) {
      if (authenticated) {
        _navigateToMap(Navigator.of(context));
      }
    });

    _viewModel.tryTokenRefresh();
  }

  @override
  void dispose() {
    _authSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: ElevatedButton(
          onPressed: () async {
            await _viewModel.authenticate();
          },
          child: const Text('AUTH!'),
        ),
      ),
    );
  }

  Future<void> _navigateToMap(NavigatorState navigator) async {
    navigator.pop();
    await navigator.push(
      MaterialPageRoute(builder: (context) => const MapScreen()),
    );
  }
}
