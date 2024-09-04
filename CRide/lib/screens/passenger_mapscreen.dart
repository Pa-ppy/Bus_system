import 'package:app/map_style.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PassengerMapScreen extends StatefulWidget {
  const PassengerMapScreen({super.key});

  @override
  _PassengerMapScreenState createState() => _PassengerMapScreenState();
}

class _PassengerMapScreenState extends State<PassengerMapScreen> {
  late GoogleMapController mapController;
  BitmapDescriptor? busIcon;
  BitmapDescriptor? driverIcon; // Add driverIcon for driver's location
  final LatLng _center =
      const LatLng(6.6747, -1.5714); // Coordinates for KNUST campus
  final MapStyle mapStyle = MapStyle(); // Instantiate the MapStyle class

  // List of bus marker positions on the KNUST campus
  final List<LatLng> _busPositions = [
    const LatLng(6.6741, -1.5668), // Random bus location 1
    const LatLng(6.6754, -1.5735), // Random bus location 2
    const LatLng(6.6763, -1.5687), // Random bus location 3
    const LatLng(6.6717, -1.5702), // Random bus location 4
    const LatLng(6.6732, -1.5749), // Random bus location 5
  ];

  final LatLng _driverPosition =
      const LatLng(6.6750, -1.5700); // Example driver position

  @override
  void initState() {
    super.initState();
    _loadIcons();
  }

  void _loadIcons() async {
    try {
      busIcon = await BitmapDescriptor.fromAssetImage(
          const ImageConfiguration(size: Size(5, 5)),
          'assets/images/bus_marker.jpg');

      driverIcon = await BitmapDescriptor.fromAssetImage(
          const ImageConfiguration(size: Size(5, 5)),
          'assets/images/driver.png'); // Make sure to have this asset

      setState(() {}); // Refresh the UI after the icon is loaded
      print('Icons loaded successfully.');
    } catch (e) {
      print('Error loading icons: $e');
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    _setMapStyle(); // Apply the map style when the map is created
  }

  void _setMapStyle() {
    mapController.setMapStyle(mapStyle.customStyle).then((_) {
      print('Map style applied');
    }).catchError((error) {
      print('Error applying map style: $error');
    });
  }

  Set<Marker> _createMarkers() {
    Set<Marker> markers = {
      Marker(
        markerId: const MarkerId('knust'),
        position: _center,
        infoWindow: const InfoWindow(title: 'KNUST Campus'),
      ),
    };

    if (busIcon != null) {
      for (int i = 0; i < _busPositions.length; i++) {
        markers.add(
          Marker(
            markerId: MarkerId('bus_$i'),
            position: _busPositions[i],
            icon: busIcon!,
            infoWindow: InfoWindow(title: 'Bus ${i + 1}'),
          ),
        );
      }
    } else {
      print('Bus icon not loaded yet.');
    }

    if (driverIcon != null) {
      markers.add(
        Marker(
          markerId: const MarkerId('driver'),
          position: _driverPosition,
          icon: driverIcon!,
          infoWindow: const InfoWindow(title: 'Driver Location'),
        ),
      );
    } else {
      print('Driver icon not loaded yet.');
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
            markers: _createMarkers(), // Use the method to create markers
          ),
          Positioned(
            top: 20, // Adjust this value to move the zoom controls up or down
            right: 10,
            child: Column(
              children: [
                FloatingActionButton(
                  onPressed: () {
                    mapController.animateCamera(CameraUpdate.zoomIn());
                  },
                  child: const Icon(Icons.zoom_in),
                ),
                const SizedBox(height: 10),
                FloatingActionButton(
                  onPressed: () {
                    mapController.animateCamera(CameraUpdate.zoomOut());
                  },
                  child: const Icon(Icons.zoom_out),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
