import 'package:app/screens/scaffolds/waiting_screen_scaffold.dart';
import 'package:flutter/material.dart';

class WaitingModeScreen extends StatelessWidget {
  const WaitingModeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Waiting Mode"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/waiting.jpg', // Ensure this path is correct and the image is in the assets directory
              height: 200,
            ),
            const SizedBox(height: 20),
            const Text(
              'If there are multiple users in the passenger mode, this will apply few mathematical calculations to get the average location of all the users and display it to the users in the Waiting mode.',
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
                        builder: (context) => const WaitingScreenScaffold()),
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
