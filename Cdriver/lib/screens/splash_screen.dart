import 'dart:async';
import 'package:app/model/shared_preference.dart';
import 'package:app/model/routes.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final PrefService _prefService = PrefService();

  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    final email = await _prefService.readCache("email");
    // final route = mapRoute;
    final route = email != null ? mapRoute : welcomeRoute;

    Timer(const Duration(seconds: 1), () {
      Navigator.of(context).pushNamed(route);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 254, 254, 254),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 150,
                child: Image.asset("assets/images/bus_icon.png",
                    fit: BoxFit.contain),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
