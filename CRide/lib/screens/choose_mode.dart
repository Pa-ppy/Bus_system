import 'package:app/screens/help_screen.dart';
import 'package:flutter/material.dart';
import 'waiting_mode.dart'; // Import the new waiting mode screen
import 'passenger_mode.dart'; // Import the new passenger mode screen

class ChooseModeScreen extends StatelessWidget {
  const ChooseModeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Choose Your Mode"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.07),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PassengerModeScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue, // Button color
                  foregroundColor: Colors.white, // Text color
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  minimumSize: const Size(double.infinity, 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text(
                  'Passenger Mode',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.07),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const WaitingModeScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue, // Button color
                  foregroundColor: Colors.white, // Text color
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  minimumSize: const Size(double.infinity, 24),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text(
                  'Waiting Mode',
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle floating action button press
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HelpScreen()),
          );
        },
        child: const Icon(Icons.help),
      ),
    );
  }
}
