import 'dart:async';

import 'package:app/map_style.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:ui'

class PassengerMapScreen extends StatefulWidget {
  const PassengerMapScreen({super.key});

  @override
  _PassengerMapScreenState createState() => _PassengerMapScreenState();
}

class _PassengerMapScreenState extends State<PassengerMapScreen> {
  late GoogleMapController mapController;
  BitmapDescriptor? busIcon;
  final LatLng _center =
      const LatLng(6.6747, -1.5714); // Coordinates for KNUST campus
  final MapStyle mapStyle = MapStyle();
  final DatabaseReference _locationRef =
      FirebaseDatabase.instance.ref().child('users');

  Position? _currentPosition;
  StreamSubscription<Position>? _positionStreamSubscription;

  @override
  void initState() {
    super.initState();
    _loadIcons();
    _getCurrentLocation();
  }

  void _loadIcons() async {
    busIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(5, 5)),
        'assets/images/bus_marker.jpg');
    setState(() {});
  }

  void _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print('Location services are not enabled.');
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        print('Location permission denied.');
        return;
      }
    }

    _positionStreamSubscription = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      ),
    ).listen((Position position) {
      setState(() {
        _currentPosition = position;
        _updateFirebaseLocation();
        _updateMapCamera();
      });
    });
  }

  void _updateFirebaseLocation() {
    if (_currentPosition != null) {
      _locationRef.child('user_id').set({
        'latitude': _currentPosition!.latitude,
        'longitude': _currentPosition!.longitude,
      });
    }
  }

  void _updateMapCamera() {
    if (_currentPosition != null) {
      mapController.animateCamera(CameraUpdate.newLatLng(
        LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
      ));
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    _setMapStyle();
    _updateMapCamera(); // Ensure the camera moves to the current position when the map is created
  }

  void _setMapStyle() {
    mapController.setMapStyle(mapStyle.customStyle);
  }

  Set<Marker> _createMarkers() {
    Set<Marker> markers = {};

    if (busIcon != null && _currentPosition != null) {
      markers.add(
        Marker(
          markerId: const MarkerId('user'),
          position:
              LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
          icon: busIcon!,
          infoWindow: const InfoWindow(title: 'Your Location'),
        ),
      );
    }

    return markers;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map Mode'),
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 15.0,
            ),
            zoomControlsEnabled: false,
            markers: _createMarkers(),
            myLocationEnabled: true, // Enable the blue dot for current location
            myLocationButtonEnabled:
                true, // Add a button to center on current location
          ),
          Positioned(
            top: 20,
            right: 10,
            child: Column(
              children: [
                FloatingActionButton(
                  onPressed: () =>
                      mapController.animateCamera(CameraUpdate.zoomIn()),
                  child: const Icon(Icons.zoom_in),
                ),
                const SizedBox(height: 10),
                FloatingActionButton(
                  onPressed: () =>
                      mapController.animateCamera(CameraUpdate.zoomOut()),
                  child: const Icon(Icons.zoom_out),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _positionStreamSubscription?.cancel();
    mapController.dispose();
    super.dispose();
  }
}
