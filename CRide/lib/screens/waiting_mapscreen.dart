// import 'package:app/map_style.dart';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore

// class WaitingMapScreen extends StatefulWidget {
//   const WaitingMapScreen({super.key});

//   @override
//   _WaitingMapScreenState createState() => _WaitingMapScreenState();
// }

// class _WaitingMapScreenState extends State<WaitingMapScreen> {
//   late GoogleMapController mapController;
//   final LatLng _center =
//       const LatLng(6.6747, -1.5714); // Coordinates for KNUST campus
//   final MapStyle mapStyle = MapStyle(); // Instantiate the MapStyle class
//   final Set<Marker> _markers = {}; // To store the markers

//   @override
//   void initState() {
//     super.initState();
//     _fetchRealTimeLocations();
//   }

//   void _onMapCreated(GoogleMapController controller) {
//     mapController = controller;
//     _setMapStyle(); // Apply the map style when the map is created
//   }

//   void _setMapStyle() {
//     mapController.setMapStyle(mapStyle.customStyle).then((_) {
//       print('Map style applied');
//     }).catchError((error) {
//       print('Error applying map style: $error');
//     });
//   }

//   void _fetchRealTimeLocations() {
//     FirebaseFirestore.instance
//         .collection('users') // Assuming 'locations' is your collection name
//         .snapshots()
//         .listen((snapshot) {
//       setState(() {
//         _markers.clear();
//         for (var document in snapshot.docs) {
//           var data = document.data();
//           var marker = Marker(
//             markerId: MarkerId(document.id),
//             position: LatLng(data['latitude'], data['longitude']),
//             infoWindow: InfoWindow(title: data['name']), // Optional: Add a name
//             icon: BitmapDescriptor.defaultMarkerWithHue(
//                 BitmapDescriptor.hueBlue), // Optional: Custom marker color
//           );
//           _markers.add(marker);
//         }
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Waiting Mode'),
//       ),
//       body: Stack(
//         children: [
//           GoogleMap(
//             onMapCreated: _onMapCreated,
//             initialCameraPosition: CameraPosition(
//               target: _center,
//               zoom: 15.0,
//             ),
//             zoomControlsEnabled: false,
//             markers: _markers, // Set the markers on the map
//           ),
//           Positioned(
//             top: 20, // Adjust this value to move the zoom controls up or down
//             right: 10,
//             child: Column(
//               children: [
//                 FloatingActionButton(
//                   onPressed: () {
//                     mapController.animateCamera(CameraUpdate.zoomIn());
//                   },
//                   child: const Icon(Icons.zoom_in),
//                 ),
//                 const SizedBox(height: 10),
//                 FloatingActionButton(
//                   onPressed: () {
//                     mapController.animateCamera(CameraUpdate.zoomOut());
//                   },
//                   child: const Icon(Icons.zoom_out),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//     );
//   }
// }

import 'package:app/map_style.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore

class WaitingMapScreen extends StatefulWidget {
  const WaitingMapScreen({super.key});

  @override
  _WaitingMapScreenState createState() => _WaitingMapScreenState();
}

class _WaitingMapScreenState extends State<WaitingMapScreen> {
  late GoogleMapController mapController;
  final LatLng _center =
      const LatLng(6.6747, -1.5714); // Coordinates for KNUST campus
  final MapStyle mapStyle = MapStyle(); // Instantiate the MapStyle class
  final Set<Marker> _markers = {}; // To store the markers

  @override
  void initState() {
    super.initState();
    _fetchRealTimeLocations();
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

  void _fetchRealTimeLocations() {
    FirebaseFirestore.instance
        .collection('users') // Reference to the 'users' collection
        .snapshots()
        .listen((snapshot) {
      setState(() {
        _markers.clear();
        for (var document in snapshot.docs) {
          var data = document.data();
          var marker = Marker(
            markerId: MarkerId(document.id),
            position: LatLng(data['latitude'], data['longitude']),
            infoWindow: InfoWindow(
              title: data['user_id'] ??
                  'User', // Assuming 'user_id' is stored, or you can use another field
            ),
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueBlue), // Optional: Custom marker color
          );
          _markers.add(marker);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Waiting Mode'),
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
            markers: _markers, // Set the markers on the map
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
