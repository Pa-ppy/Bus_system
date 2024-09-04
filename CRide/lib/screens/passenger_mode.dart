import 'package:app/screens/scaffolds/passenger_screen_scaffold.dart';
import 'package:flutter/material.dart';

class PassengerModeScreen extends StatelessWidget {
  const PassengerModeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Passenger Mode"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/passenger.jpg', // Ensure this path is correct and the image is in the assets directory
              height: 200,
            ),
            const SizedBox(height: 20),
            const Text(
              'The earliest passengers or the crew itself can enter the Passenger mode which will utilize their current location data fetched using GPS and provide it to the user under the Waiting mode.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 40),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.07),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ScreenScaffold()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent, // Button color
                  foregroundColor: Colors.white, // Text color
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  minimumSize: const Size(double.infinity, 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text(
                  'Get Started',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
