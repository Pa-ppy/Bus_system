import 'package:app/screens/login_screen.dart';
import 'package:app/screens/choose_mode.dart';
import 'package:app/screens/registration_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              _buildMainContent(),
              _buildButtons(),
              _buildMapButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMainContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 20),
        Lottie.asset('assets/images/bus.json'),
        const SizedBox(height: 20),
        Text(
          "Welcome to \n CampRide",
          style: GoogleFonts.poppins(
            fontSize: 34,
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 38),
      child: Container(
        height: 65,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 3,
              offset: const Offset(0, 5),
            ),
          ],
          color: Colors.lightBlue,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            _buildButton(
              text: 'Register',
              backgroundColor: Colors.white,
              textColor: Colors.blue,
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => const RegistrationScreen(),
                  ),
                );
              },
            ),
            _buildButton(
              text: 'Login',
              backgroundColor: Colors.lightBlue,
              textColor: Colors.white,
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMapButton() {
    return Padding(
      padding:
          const EdgeInsets.only(top: 20), // Add some space above the button
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => const ChooseModeScreen(),
            ),
          );
        },
        child: Container(
          height: 65,
          width: 200,
          decoration: BoxDecoration(
            color: Colors.lightBlue,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 3,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: const Center(
            child: Text(
              'Go to Map',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButton({
    required String text,
    required Color backgroundColor,
    required Color textColor,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.lightBlue,
              width: 0.9,
            ),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
