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

  @override
  void initState() {
    super.initState();
    _viewModel = GetIt.I<AuthScreenVM>();

    _handleCurrentAuthState();
  }

  void _handleCurrentAuthState() async {
    if (await _viewModel.authenticated) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
        await _navigateToMap(
          Navigator.of(context),
        ); // TODO This widget has been unmounted, so the State no longer has a context (and should be considered defunct).
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final navigator = Navigator.of(context);
    return Material(
      child: Center(
        child: GestureDetector(
          onTap: () async {
            final success = await _viewModel.authenticate();
            // TODO listen for token stream instead
            if (success) {
              await _navigateToMap(navigator);
            }
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
